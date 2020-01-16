defmodule AOC2019.Q9 do
  alias AOC2019.Intcode

  def p1(ops_list) do
    Intcode.new(ops_list)
    |> Intcode.input([1])
    |> Intcode.calc_until_halt()
    |> Intcode.outputs()
    |> hd()
  end
end
