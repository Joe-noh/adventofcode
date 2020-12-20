defmodule AOC2020.Q19Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q19.p1() == 109
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q19.p2() == -1
    end
  end

  def input do
    AOC.Input.read!(2020, 19) |> String.split("\n")
  end
end
