defmodule AOC2019.Q5Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert AOC2019.Q5.p1() == 9961446
    end
  end

  describe "part 2" do
    test "solve" do
      assert AOC2019.Q5.p2() == 742621
    end
  end
end
