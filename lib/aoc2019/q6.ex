defmodule AOC2019.Q6 do
  def p1(list) do
    rev_map = reverse_map(list)

    rev_map
    |> Map.keys()
    |> Enum.map(fn key -> distance_to_root(rev_map, key) end)
    |> Enum.sum()
  end

  def p2(list) do
    rev_map = reverse_map(list)

    m1 = orbits_to_root(rev_map, "YOU") |> Enum.reverse()
    m2 = orbits_to_root(rev_map, "SAN") |> Enum.reverse()

    common = Enum.zip(m1, m2) |> Enum.count(fn {a, b} -> a == b end)
    length(m1) + length(m2) - 2*common
  end

  defp reverse_map(list) do
    list
    |> Enum.map(fn [a, b] -> {b, a} end)
    |> Enum.into(%{})
  end

  defp distance_to_root(map, key) do
    distance_to_root(map, key, 0)
  end

  defp distance_to_root(map, key, d) do
    case Map.get(map, key) do
      nil -> d
      key -> distance_to_root(map, key, d+1)
    end
  end

  defp orbits_to_root(map, key) do
    orbits_to_root(map, key, [])
  end

  defp orbits_to_root(map, key, acc) do
    case Map.get(map, key) do
      nil -> Enum.reverse(acc)
      key -> orbits_to_root(map, key, [key | acc])
    end
  end
end
