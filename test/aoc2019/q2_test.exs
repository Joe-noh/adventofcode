defmodule AOC2019.Q2Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "puts", context do
      AOC2019.Q2.p1() |> TestHelpers.puts(context)
    end
  end

  describe "part 2" do
    test "puts", context do
      AOC2019.Q2.p2() |> TestHelpers.puts(context)
    end
  end
end
