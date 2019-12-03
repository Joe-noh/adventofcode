defmodule AOC2018.Q3 do
  def part1 do
    AOC.Input.stream!(2018, 3)
    |> Stream.map(&split_parts/1)
    |> Stream.flat_map(fn [id, {left, top}, {width, height}] ->
      for w <- 0..width-1 do
        for h <- 0..height-1 do
          {id, {left + w, top + h}}
        end
      end
      |> List.flatten
    end)
    |> Enum.reduce({%{}, {0, 0}}, fn ({_id, {x, y}}, {acc, {max_x, max_y}}) ->
      acc = acc |> Map.update({x, y}, 1, fn c -> c + 1 end)
      {acc, {max(max_x, x), max(max_y, y)}}
    end)
    |> elem(0)
    |> count_multiple_marked()
  end

  def part2 do
    AOC.Input.stream!(2018, 3)
    |> Stream.map(&split_parts/1)
    |> Stream.map(fn [id, {left, top}, {width, height}] ->
      coords =
        for w <- 0..width-1 do
          for h <- 0..height-1 do
            {left + w, top + h}
          end
        end

      {id, List.flatten(coords)}
    end)
    |> find_not_overlapped()
    |> elem(1)
    |> MapSet.to_list()
    |> List.first()
  end

  defp split_parts(line) do
    [id | parts] = line |> String.split(~r/[:@,x\s]+/, trim: true)

    [left, top, width, height] =
      parts
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(& elem &1, 0)

    [id, {left, top}, {width, height}]
  end

  defp count_multiple_marked(map) do
    Enum.count(map, fn
      {_, 1} -> false
      {_, _} -> true
    end)
  end

  defp find_not_overlapped(id_coords) do
    Enum.reduce(id_coords, {%{}, MapSet.new}, fn ({id, coords}, {acc, not_overlapped}) ->
      {acc, not_overlapped, overlapped} =
        Enum.reduce(coords, {acc, not_overlapped, false}, fn ({x, y}, {acc, not_overlapped, overlapped}) ->
          case Map.get(acc, {x, y}) do
            nil ->
              acc = acc |> Map.put({x, y}, id)
              not_overlapped = not_overlapped |> MapSet.put(id)

              {acc, not_overlapped, overlapped || false}

            existing_id ->
              acc = acc |> Map.put({x, y}, id)
              not_overlapped = not_overlapped |> MapSet.delete(id) |> MapSet.delete(existing_id)

              {acc, not_overlapped, overlapped || true}
          end
        end)

      if overlapped do
        {acc, MapSet.delete(not_overlapped, id)}
      else
        {acc, not_overlapped}
      end
    end)
  end
end
