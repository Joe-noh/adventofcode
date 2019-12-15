defmodule AOC2019.Q4Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      [from, to] = input()

      assert AOC2019.Q4.p1(from, to) == 960
    end
  end

  describe "part 2" do
    test "solve" do
      [from, to] = input()

      assert AOC2019.Q4.p2(from, to) == 626
    end
  end

  def input do
    AOC2019.Q4.input()
    |> String.split("-")
    |> Enum.map(fn n -> Integer.parse(n) |> elem(0) end)
  end
end
