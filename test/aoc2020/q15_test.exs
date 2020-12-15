defmodule AOC2020.Q15Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q15.p1() == 475
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q15.p2() == 11261
    end
  end

  def input do
    AOC.Input.read!(2020, 15)
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end
end
