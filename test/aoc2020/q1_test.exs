defmodule AOC2020.Q1Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q1.p1() == 357504
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q1.p2() == 12747392
    end
  end

  def input do
    AOC.Input.read_as_numbers!(2020, 1)
  end
end
