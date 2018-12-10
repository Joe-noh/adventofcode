defmodule AOC.Q6 do
  def part1 do
    coordinates = input_coordinates()
    {{min_x, min_y}, {max_x, max_y}} = search_area(coordinates)

    grid = for x <- (min_x..max_x), y <- (min_y..max_y), do: {x, y}
    {infinite_areas, area_map} =
      Enum.reduce(grid, {[], %{}}, fn {x, y}, {infinite_areas, acc} ->
        {_distance, coord} =
          coordinates
          |> Enum.reduce({max_y + max_x, nil}, fn coord, {min_distance, closest} ->
            distance = manhattan_distance(coord, {x, y})
            cond do
              distance == 0 ->
                {min_distance, coord}
              min_distance == distance ->
                {min_distance, nil}
              min_distance < distance ->
                {min_distance, closest}
              min_distance > distance ->
                {distance, coord}
            end
          end)

        if (x in [min_x, max_x]) || (y in [min_y, max_y]) do
          {[coord | infinite_areas], Map.put(acc, {x, y}, coord)}
        else
          {infinite_areas, Map.put(acc, {x, y}, coord)}
        end
      end)

    infinite_areas = Enum.uniq(infinite_areas) |> IO.inspect

    area_map
    |> Enum.reject(fn {_xy, coord} -> coord in infinite_areas end)
    |> Enum.group_by(fn {_, coord} -> coord end, fn {xy, _} -> xy end)
    |> Enum.map(fn {coord, area_coords} -> {coord, Enum.count(area_coords)} end)
    |> Enum.max_by(fn {_coord, area} -> area end)
  end

  def part2 do
    coordinates = input_coordinates()
    {{min_x, min_y}, {max_x, max_y}} = search_area(coordinates)

    grid = for x <- (min_x..max_x), y <- (min_y..max_y), do: {x, y}

    Enum.reduce(grid, 0, fn {x, y}, area_size ->
      coordinates
      |> Enum.map(fn coord -> manhattan_distance(coord, {x, y}) end)
      |> Enum.sum()
      |> case do
        distance when distance < 10000 ->
          area_size + 1
        _ ->
          area_size
      end
    end)
  end

  defp input_coordinates do
    AOC.Input.stream!(2018, 6)
    |> Stream.map(& String.split(&1, ", "))
    |> Stream.map(fn [x, y] ->
      {x, _} = Integer.parse(x)
      {y, _} = Integer.parse(y)

      {x, y}
    end)
    |> Enum.into([])
  end

  defp search_area(coordinates) do
    {{min_x, _}, {max_x, _}} = coordinates |> Enum.min_max_by(fn {x, _} -> x end)
    {{_, min_y}, {_, max_y}} = coordinates |> Enum.min_max_by(fn {_, y} -> y end)

    {{min_x, min_y}, {max_x, max_y}}
  end

  defp manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end
end
