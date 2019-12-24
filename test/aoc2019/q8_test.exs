defmodule AOC2019.Q8Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2019.Q8.p1() == 1950
    end
  end

  describe "part 2" do
    test "solve" do
      expected = Enum.join([
        "XXXX X  X  XX  X  X X    ",
        "X    X X  X  X X  X X    ",
        "XXX  XX   X  X XXXX X    ",
        "X    X X  XXXX X  X X    ",
        "X    X X  X  X X  X X    ",
        "X    X  X X  X X  X XXXX ",
      ], "\n")

      assert input() |> AOC2019.Q8.p2() == expected
    end
  end

  def input do
    AOC.Input.read!(2019, 8) |> String.codepoints()
  end
end
