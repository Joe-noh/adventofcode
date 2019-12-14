defmodule AOC2019.Q4Test do
  use ExUnit.Case, async: true

  describe "p1" do
    test "puts", context do
      [from, to] = input()

      AOC2019.Q4.p1(from, to) |> TestHelpers.puts(context)
    end
  end

  describe "p2" do
    test "puts", context do
      [from, to] = input()

      AOC2019.Q4.p2(from, to) |> TestHelpers.puts(context)
    end
  end

  def input do
    AOC2019.Q4.input()
    |> String.split("-")
    |> Enum.map(fn n -> Integer.parse(n) |> elem(0) end)
  end
end
