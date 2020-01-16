defmodule AOC2019.Q7 do
  alias AOC2019.Intcode

  def p1(ops_list) do
    [0, 1, 2, 3, 4]
    |> permutations()
    |> Enum.map(fn phases ->
      Enum.reduce(phases, 0, fn (phase, input) ->
        Intcode.new(ops_list)
        |> Intcode.input([phase, input])
        |> Intcode.calc_until_output()
        |> case do
          {:output, output, _} -> output
          {:halt, _} -> 0
        end
      end)
    end)
    |> Enum.max()
  end

  defp permutations([]) do
    [[]]
  end

  defp permutations(list) do
    for head <- list, tail <- permutations(list -- [head]) do
      [head | tail]
    end
  end
end
