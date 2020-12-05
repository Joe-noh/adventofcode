defmodule AOC2020.Q5Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q5.p1() == 947
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q5.p2() == 636
    end
  end

  defp input do
    AOC.Input.stream!(2020, 5)
  end
end
