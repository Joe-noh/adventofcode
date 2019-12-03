defmodule AOC2018.Q5 do
  def part1 do
    input_codepoints()
    |> react()
    |> length
  end

  def part2 do
    polymers = input_codepoints()

    polymers
    |> Enum.uniq_by(&String.downcase/1)
    |> Enum.map(&String.downcase/1)
    |> Enum.map(fn unit ->
      len = polymers
        |> Enum.reject(& &1 == unit || &1 == String.upcase(unit))
        |> react()
        |> length

      {unit, len}
    end)
    |> Enum.min_by(fn {_unit, len} -> len end)
  end

  defp input_codepoints do
    AOC.Input.read!(2018, 5) |> String.trim() |> String.codepoints()
  end

  defp react(polymers) do
    react(polymers, [])
  end

  defp react([head | tail], []) do
    react(tail, [head])
  end

  defp react([head | tail], reacted = [reacted_head | reacted_tail]) do
    if react?(head, reacted_head) do
      react(tail, reacted_tail)
    else
      react(tail, [head | reacted])
    end
  end

  defp react([], reacted) do
    reacted
  end

  defp react?(a, a) do
    false
  end
  defp react?(a, b) do
    (String.downcase(a) == b) || (a == String.downcase(b))
  end
end
