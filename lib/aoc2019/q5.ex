defmodule AOC2019.Q5 do
  alias AOC2019.Intcode

  def p1 do
    input()
    |> Intcode.new()
    |> Intcode.input(1)
    |> Intcode.calc_until_halt()
    |> Intcode.outputs()
    |> hd()
  end

  def p2 do
    input()
    |> Intcode.new()
    |> Intcode.input(5)
    |> Intcode.calc_until_halt()
    |> Intcode.outputs()
    |> hd()
  end

  defp input() do
    AOC.Input.read!(2019, 5)
    |> String.split(",")
    |> Enum.map(&parse_int/1)
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end
end
