defmodule AOC2020.Q14Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q14.p1() == 8471403462063
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q14.p2() == 2667858637669
    end
  end

  def input do
    AOC.Input.stream!(2020, 14)
  end
end
