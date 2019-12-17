defmodule AOC2019.Q5 do
  def p1 do
    input() |> AOC2019.Intcode.calc()
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
