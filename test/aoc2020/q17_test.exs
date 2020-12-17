defmodule AOC2020.Q17Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q17.p1() == 306
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q17.p2() == 2572
    end
  end

  def input do
    AOC.Input.read!(2020, 17) |> String.split("\n", trim: true)
  end
end
