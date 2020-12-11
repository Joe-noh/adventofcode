defmodule AOC2020.Q11 do
  def p1(lines) do
    lines
    |> build_seats_map()
    |> run(1, 4)
    |> Map.values()
    |> Enum.count(fn c -> c == "#" end)
  end

  def p2(lines) do
    lines
    |> build_seats_map()
    |> run(1000, 5)
    |> Map.values()
    |> Enum.count(fn c -> c == "#" end)
  end

  defp build_seats_map(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, j}, line_acc ->
        Map.put(line_acc, {i, j}, char)
      end)
      |> Map.merge(acc)
    end)
  end

  defp run(seats_map, distance, threshould) do
    1..100
    |> Enum.reduce_while(seats_map, fn _, map ->
      next_map = iterate(map, distance, threshould)

      if Map.equal?(map, next_map) do
        {:halt, map}
      else
        {:cont, next_map}
      end
    end)
  end

  defp iterate(seats_map, distance, threshould) do
    seats_map
    |> Enum.reduce(%{}, fn {{x, y}, char}, next_map ->
      case char do
        "L" ->
          if count_occupied_adjacent(seats_map, {x, y}, distance) == 0 do
            Map.put(next_map, {x, y}, "#")
          else
            Map.put(next_map, {x, y}, "L")
          end

        "#" ->
          if count_occupied_adjacent(seats_map, {x, y}, distance) >= threshould do
            Map.put(next_map, {x, y}, "L")
          else
            Map.put(next_map, {x, y}, "#")
          end

        "." ->
          Map.put(next_map, {x, y}, ".")
      end
    end)
  end

  defp count_occupied_adjacent(seats_map, {x, y}, distance) do
    [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]
    |> Enum.count(fn direction ->
      first_adjacent_occupied?(seats_map, {x, y}, direction, distance)
    end)
  end

  defp first_adjacent_occupied?(seats_map, {x, y}, {dx, dy}, distance) do
    1..distance
    |> Enum.reduce_while(nil, fn distance, _ ->
      coord = {x + (distance * dx), y + (distance * dy)}

      case Map.get(seats_map, coord) do
        nil -> {:halt, false}
        "." -> {:cont, nil}
        "#" -> {:halt, true}
        "L" -> {:halt, false}
      end
    end)
  end
end
