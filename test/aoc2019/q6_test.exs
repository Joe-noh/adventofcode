defmodule AOC2019.Q6Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2019.Q6.p1() == 241064
    end
  end

  describe "part 2" do
    test "example" do
      list = ~w[COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L K)YOU I)SAN] |> Enum.map(&String.split(&1, ")"))

      assert AOC2019.Q6.p2(list) == 4
    end

    test "solve" do
      assert input() |> AOC2019.Q6.p2() == 418
    end
  end

  def input do
    AOC.Input.stream!(2019, 6)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ")"))
    |> Enum.into([])
  end
end
