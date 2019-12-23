defmodule AOC2019.Q10 do
  def p1(lines) do
    map = asteroids_map(lines)
    coords = asteroid_coords(map)

    coords
    |> Enum.map(fn coord -> detectable_count(map, coords, coord) end)
    |> Enum.max()
  end

  def p2(lines) do
    map = asteroids_map(lines)
    coords = asteroid_coords(map)

    station_coord = Enum.max_by(coords, fn coord -> detectable_count(map, coords, coord) end)
    map = Map.put(map, station_coord, false)

    directions =
      coords
      |> Enum.filter(fn coord -> coord != station_coord end)
      |> Enum.map(fn coord -> direction(station_coord, coord) end)
      |> Enum.uniq()
      |> Enum.sort_by(fn coord -> angle(coord) end)

    directions_length = length(directions)
    directions_map = directions |> Enum.with_index() |> Enum.map(fn {d, i} -> {i, d} end) |> Enum.into(%{})

    {x, y} =
      Enum.reduce_while(1..10000, {nil, 0, 0, map}, fn _i, {_vaporized, count, index, acc} ->
        direction = Map.get(directions_map, rem(index, directions_length))

        case vaporize(acc, station_coord, direction) do
          {nil, map} -> {:cont, {nil, count, index+1, map}}
          {vaporized, map} ->
            if count == 199 do
              {:halt, vaporized}
            else
              {:cont, {vaporized, count+1, index+1, map}}
            end
        end
      end)

    100*x + y
  end

  defp asteroids_map(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.trim()
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn
        {"#", x}, map -> Map.put(map, {x, y}, true)
        {".", x}, map -> Map.put(map, {x, y}, false)
      end)
    end)
  end

  defp asteroid_coords(map) do
    Enum.reduce(map, [], fn
      {coord, true}, acc -> [coord | acc]
      {_, false}, acc -> acc
    end)
  end

  defp detectable_count(asteroid_map, asteroid_coords, coord) do
    asteroid_coords
    |> Enum.map(fn asteroid_coord -> direction(coord, asteroid_coord) end)
    |> Enum.uniq()
    |> Enum.count(fn direction -> detect_asteroid?(asteroid_map, coord, direction) end)
  end

  defp direction({x, y}, {x, y}), do: {0, 0}

  defp direction({x1, y1}, {x2, y2}) do
    {x, y} = {x2 - x1, y2 - y1}
    gcd = Integer.gcd(x, y)

    {div(x, gcd), div(y, gcd)}
  end

  defp angle({0, y}) when y < 0, do: 0.0
  defp angle({0, y}) when 0 < y, do: 180.0
  defp angle({x, y}), do: :math.atan2(-x, y) * 180 / :math.pi() + 180.0

  defp detect_asteroid?(_asteroid_map, _from, {0, 0}), do: false

  defp detect_asteroid?(asteroid_map, from, {dx, dy}) do
    Enum.reduce_while(1..1000, from, fn _, {x, y} ->
      case Map.get(asteroid_map, {x, y}) do
        true -> {:halt, true}
        false -> {:cont, {x + dx, y + dy}}
        nil -> {:halt, false}
      end
    end)
  end

  defp vaporize(asteroid_map, from, {dx, dy}) do
    Enum.reduce_while(1..10000, from, fn _, {x, y} ->
      case Map.get(asteroid_map, {x, y}) do
        true -> {:halt, {x, y}}
        false -> {:cont, {x + dx, y + dy}}
        nil -> {:halt, nil}
      end
    end)
    |> case do
      nil -> {nil, asteroid_map}
      coord -> {coord, Map.put(asteroid_map, coord, false)}
    end
  end
end
