defmodule AOC2020.Q13Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q13.p1() == 2845
    end
  end

  describe "part 2" do
    test "solve" do
    end
  end

  def input do
    AOC.Input.read!(2020, 13) |> String.split("\n", trim: true)
  end
end
