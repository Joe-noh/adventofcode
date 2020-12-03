defmodule AOC2020.Q3Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q3.p1() == 262
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q3.p2() == 2698900776
    end
  end

  defp input do
    AOC.Input.read!(2020, 3) |> String.split()
  end
end
