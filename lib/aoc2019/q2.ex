defmodule AOC2019.Q2 do
  def p1 do
    input() |> AOC2019.Intcode.calc({12, 2})
  end

  def p2 do
    codes = input()

    # bruteforce
    pairs = for month <- 0..99, day <- 0..99, into: [], do: {month, day}

    {noun, verb} = Enum.find(pairs, fn pair ->
      19690720 == AOC2019.Intcode.calc(codes, pair)
    end)

    noun * 100 + verb
  end

  defp input() do
    AOC.Input.read!(2019, 2)
    |> String.split(",")
    |> Enum.map(&parse_int/1)
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end
end
