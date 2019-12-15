defmodule AOC2019.Q1Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert 3291760 == AOC2019.Q1.p1()
    end
  end

  describe "part 2" do
    test "solve" do
      assert 4934767 == AOC2019.Q1.p2()
    end
  end
end
