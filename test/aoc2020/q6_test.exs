defmodule AOC2020.Q6Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q6.p1() == 6457
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q6.p2() == 3260
    end
  end

  defp input do
    AOC.Input.read!(2020, 6) |> String.split("\n")
  end
end
