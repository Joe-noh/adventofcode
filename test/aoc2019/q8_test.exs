defmodule AOC2019.Q8Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2019.Q8.p1() == 1950
    end
  end

  describe "part 2" do
    test "solve" do
      input() |> AOC2019.Q8.p2()
    end
  end

  def input do
    AOC.Input.read!(2019, 8) |> String.codepoints()
  end
end
