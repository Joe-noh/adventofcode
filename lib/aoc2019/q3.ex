defmodule AOC2019.Q3 do
  def input do
    AOC.Input.stream!(2019, 3)
    |> Stream.map(fn line -> String.split(line, ",") end)
    |> Enum.to_list()
  end

  def p1(ops_list) do
    [path1, path2] =
      ops_list
      |> Enum.map(fn ops ->
        ops
        |> Enum.reduce({[], {0, 0}}, fn op, {coords, origin} ->
          tracks = [current_coord | _] = tracks(op, origin)

          {tracks ++ coords, current_coord}
        end)
      end)
      |> Enum.map(fn {coords, _} ->
        Enum.uniq(coords)
        |> Enum.reduce(%{}, fn coord, acc -> Map.put(acc, coord, true) end)
      end)

    intersection(path1, path2)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  defp tracks(op, origin) do
    case op do
      "U" <> n -> populate(origin, parse_int(n), { 0,  1})
      "R" <> n -> populate(origin, parse_int(n), { 1,  0})
      "D" <> n -> populate(origin, parse_int(n), { 0, -1})
      "L" <> n -> populate(origin, parse_int(n), {-1,  0})
    end
  end

  defp populate({x, y}, distance, {dx, dy}) do
    Enum.map(1..distance, fn d -> {x + d * dx, y + d * dy} end) |> Enum.reverse()
  end

  defp intersection(list1, list2) do
    list1
    |> Map.keys()
    |> Enum.filter(fn key -> Map.get(list2, key) end)
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end
end
