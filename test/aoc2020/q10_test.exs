defmodule AOC2020.Q10Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q10.p1() == 2100
    end
  end

  describe "part 2" do
    test "example 1" do
      input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]

      assert input |> AOC2020.Q10.p2() == 8
    end

    test "example 2" do
      input = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

      assert input |> AOC2020.Q10.p2() == 19208
    end

    test "solve" do
      assert input() |> AOC2020.Q10.p2() == 16198260678656
    end
  end

  def input do
    AOC.Input.read_as_numbers!(2020, 10)
  end
end
