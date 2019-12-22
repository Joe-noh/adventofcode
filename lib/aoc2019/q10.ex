defmodule AOC2019.Q10 do
  def p1(lines) do
    map = asteroids_map(lines)
    asteroid_coords = Enum.reduce(map, [], fn
      {coord, true}, acc -> [coord | acc]
      {_, false}, acc -> acc
    end)

    asteroid_coords
    |> Enum.map(fn coord ->
      asteroid_coords
      |> Enum.map(fn asteroid_coord -> direction(coord, asteroid_coord) end)
      |> Enum.uniq()
      |> Enum.count(fn direction -> detect_asteroid?(map, coord, direction) end)
    end)
    |> Enum.max()
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

  defp direction({x, y}, {x, y}), do: {0, 0}

  defp direction({x1, y1}, {x2, y2}) do
    {x, y} = {x2 - x1, y2 - y1}
    gcd = Integer.gcd(x, y)

    {div(x, gcd), div(y, gcd)}
  end

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
end
