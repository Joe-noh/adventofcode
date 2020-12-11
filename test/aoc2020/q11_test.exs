defmodule AOC2020.Q11Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q11.p1() == 2152
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q11.p2() == 1937
    end
  end

  def input do
    AOC.Input.read!(2020, 11) |> String.split("\n", trim: true)
  end
end
