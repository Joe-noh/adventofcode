defmodule AOC2020.Q9Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q9.p1() == 1504371145
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q9.p2() == 183278487
    end
  end

  def input do
    AOC.Input.read_as_numbers!(2020, 9)
  end
end
