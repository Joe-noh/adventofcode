defmodule AOC2020.Q10 do
  def p1(list) do
    diffs = diff_list(list)

    Enum.frequencies([3 | diffs])
    |> Map.values()
    |> Enum.reduce(fn a, b -> a * b end)
  end

  def p2(list) do
    diffs = diff_list(list)

     1 + count_paths(diffs)
  end

  defp diff_list(list) do
    {diff_list, _} =
      list
      |> Enum.sort()
      |> Enum.map_reduce(0, fn a, b -> {a - b, a} end)

    diff_list
  end

  defp count_paths([a, b | tail]) when b + a <= 3 do
    1 + do_count_paths([a + b | tail]) + do_count_paths([b | tail])
  end

  defp count_paths([]) do
    0
  end

  defp count_paths([_ | tail]) do
    do_count_paths(tail)
  end

  defp do_count_paths([]) do
    0
  end

  defp do_count_paths(list) do
    case Process.get(list) do
      nil ->
        count = count_paths(list)
        Process.put(list, count)
        count

      cache ->
        cache
    end
  end
end
