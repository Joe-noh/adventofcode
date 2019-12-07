defmodule AOC2019.Q3 do
  def input do
    AOC.Input.stream!(2019, 3)
    |> Stream.map(fn line -> String.split(line, ",") end)
    |> Enum.to_list()
  end

  def p1(ops_list) do
    [path1, path2] = ops_to_paths(ops_list)

    intersection(path1, path2)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  def p2(ops_list) do
    [path1, path2] = ops_to_paths(ops_list)

    intersection(path1, path2)
    |> Enum.map(fn coord -> min_steps(path1, coord) + min_steps(path2, coord) end)
    |> Enum.min()
  end

  defp ops_to_paths(ops_list) do
    ops_list
    |> Enum.map(fn ops ->
      {coords, _} = Enum.reduce(ops, {[], {0, 0}}, fn op, {coords, origin} ->
        tracks = [current_coord | _] = tracks(op, origin)

        {tracks ++ coords, current_coord}
      end)

      Enum.reverse(coords)
    end)
  end

  defp tracks(op, origin) do
    case op do
      "U" <> n -> populate(origin, parse_int(n), { 0,  1})
      "R" <> n -> populate(origin, parse_int(n), { 1,  0})
      "D" <> n -> populate(origin, parse_int(n), { 0, -1})
      "L" <> n -> populate(origin, parse_int(n), {-1,  0})
    end
  end

  defp min_steps(path, coord) do
    Enum.find_index(path, &(&1 == coord))  + 1
  end

  defp populate({x, y}, distance, {dx, dy}) do
    Enum.map(1..distance, fn d -> {x + d * dx, y + d * dy} end) |> Enum.reverse()
  end

  defp intersection(list1, list2) do
    [_map1, map2] = Enum.map([list1, list2], fn list ->
      Enum.uniq(list) |> Enum.reduce(%{}, & Map.put(&2, &1, true))
    end)

    list1 |> Enum.filter(fn key -> Map.get(map2, key) end)
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end
end
