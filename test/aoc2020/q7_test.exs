defmodule AOC2020.Q6Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q7.p1() == 177
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q7.p2() == 34988
    end
  end

  defp input do
    AOC.Input.stream!(2020, 7)
  end
end
