defmodule AOC2020.Q16Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q16.p1() == 21978
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q16.p2() == 1053686852011
    end
  end

  def input do
    AOC.Input.read!(2020, 16) |> String.split("\n", trim: true)
  end
end
