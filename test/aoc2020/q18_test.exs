defmodule AOC2020.Q18Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q18.p1() == 7293529867931
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q18.p2() == 60807587180737
    end
  end

  def input do
    AOC.Input.read!(2020, 18) |> String.split("\n", trim: true)
  end
end
