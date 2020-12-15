defmodule AOC2020.Q15 do
  def p1(numbers) do
    solve(numbers, 2020)
  end

  def p2(numbers) do
    solve(numbers, 30000000) # too slow. need better algorithm.
  end

  defp solve(numbers, n) do
    initial =
      numbers
      |> Enum.with_index(1)
      |> Enum.reduce(%{}, fn {n, i}, acc -> Map.put(acc, n, [i]) end)

    start = length(numbers) + 1
    last_number = List.last(numbers)

    {_, last_spoken} =
      start..n
      |> Enum.reduce({initial, last_number}, fn i, {occurrences, last_spoken} ->
        next_number =
          case Map.get(occurrences, last_spoken) do
            [i1, i2 | _] -> i1 - i2
            [_] -> 0
          end

        occurrences = Map.update(occurrences, next_number, [i], fn list -> [i | list] end)

        {occurrences, next_number}
      end)

    last_spoken
  end
end
