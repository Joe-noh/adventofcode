defmodule AOC.Q1 do
  def p1 do
    AOC.Input.stream!(2018, 1)
    |> Stream.map(&parse_int/1)
    |> Enum.sum()
  end

  def p2 do
    AOC.Input.stream!(2018, 1)
    |> Stream.map(&parse_int/1)
    |> Stream.cycle
    |> Enum.reduce_while({0, MapSet.new([0])}, fn x, {current, acc} ->
      new = x + current
      if MapSet.member?(acc, new) do
        {:halt, new}
      else
        {:cont, {new, MapSet.put(acc, new)}}
      end
    end)
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end
end
