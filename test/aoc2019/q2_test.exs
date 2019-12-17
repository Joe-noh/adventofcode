defmodule AOC2019.Q2Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "sove" do
      assert 2894520 == AOC2019.Q2.p1()
    end
  end

  describe "part 2" do
    test "solve" do
      assert 9342 == AOC2019.Q2.p2()
    end
  end
end
