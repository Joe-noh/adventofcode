defmodule AOC2019.Q9Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      codes = [1102, 34915192, 34915192, 7, 4, 7, 99, 0]

      assert AOC2019.Q9.p1(codes) == 1219070632396864
    end

    test "example 2" do
      codes = [104, 1125899906842624, 99]

      assert AOC2019.Q9.p1(codes) == 1125899906842624
    end

    test "solve" do
       assert input() |> AOC2019.Q9.p1() == 3380552333
    end
  end

  def input do
    AOC.Input.read!(2019, 9)
    |> String.split(",")
    |> Enum.map(fn n -> Integer.parse(n) |> elem(0) end)
  end
end
