defmodule AOC2019.Q7Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      codes = [3, 15, 3, 16, 1002, 16, 10, 16, 1, 16, 15, 15, 4, 15, 99, 0, 0]

      assert AOC2019.Q7.p1(codes) == 43210
    end

    test "example 2" do
      codes = [3, 23, 3, 24, 1002, 24, 10, 24, 1002, 23, -1, 23, 101, 5, 23, 23, 1, 24, 23, 23, 4, 23, 99, 0, 0]

      assert AOC2019.Q7.p1(codes) == 54321
    end

    test "example 3" do
      codes = [3, 31, 3, 32, 1002, 32, 10, 32, 1001, 31, -2, 31, 1007, 31, 0, 33, 1002, 33, 7, 33, 1, 33, 31, 31, 1, 32, 31, 31, 4, 31, 99, 0, 0, 0]

      assert AOC2019.Q7.p1(codes) == 65210
    end

    test "solve" do
      assert input() |> AOC2019.Q7.p1() == 17440
    end
  end

  def input do
    AOC.Input.read!(2019, 7)
    |> String.split(",")
    |> Enum.map(fn n -> Integer.parse(n) |> elem(0) end)
  end
end
