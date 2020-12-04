defmodule AOC2020.Q4Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q4.p1() == 250
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q4.p2() == 158
    end
  end

  defp input do
    AOC.Input.read!(2020, 4) |> String.split("\n")
  end
end
