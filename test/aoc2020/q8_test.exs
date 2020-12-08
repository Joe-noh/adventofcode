defmodule AOC2020.Q8Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q8.p1() == 1614
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q8.p2() == 1260
    end
  end

  defp input do
    AOC.Input.read!(2020, 8) |> String.trim() |> String.split("\n")
  end
end
