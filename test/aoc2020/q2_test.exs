defmodule AOC2020.Q2Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "solve" do
      assert input() |> AOC2020.Q2.p1() == 483
    end
  end

  describe "part 2" do
    test "solve" do
      assert input() |> AOC2020.Q2.p2() == 482
    end
  end

  defp input do
    AOC.Input.stream!(2020, 2)
    |> Stream.map(fn line ->
      [min, max, char, password | _] = String.split(line, ~r/[\-\s:]+/)
      min = Integer.parse(min) |> elem(0)
      max = Integer.parse(max) |> elem(0)

      List.to_tuple([min, max, char, password])
    end)
    |> Enum.to_list()
  end
end
