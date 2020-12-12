defmodule AOC2020.Q12Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q12.p1() == 1007
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q12.p2() == 41212
    end
  end

  def input do
    AOC.Input.read!(2020, 12) |> String.split("\n", trim: true)
  end
end
