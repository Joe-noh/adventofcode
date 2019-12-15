defmodule AOC2019.Q3Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      ops_list = [
        ~w[U7 R6 D4 L4],
        ~w[R8 U5 L5 D3]
      ]

      assert 6 == AOC2019.Q3.p1(ops_list)
    end

    test "example 2" do
      ops_list = [
        ~w[R75 D30 R83 U83 L12 D49 R71 U7 L72],
        ~w[U62 R66 U55 R34 D71 R55 D58 R83]
      ]

      assert 159 == AOC2019.Q3.p1(ops_list)
    end

    test "example 3" do
      ops_list = [
        ~w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51],
        ~w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7]
      ]

      assert 135 == AOC2019.Q3.p1(ops_list)
    end

    test "solve" do
      assert AOC2019.Q3.input() |> AOC2019.Q3.p1() == 266
    end
  end

  describe  "part 2" do
    test "example 1" do
      ops_list = [
        ~w[U7 R6 D4 L4],
        ~w[R8 U5 L5 D3]
      ]

      assert 30 == AOC2019.Q3.p2(ops_list)
    end

    test "example 2" do
      ops_list = [
        ~w[R75 D30 R83 U83 L12 D49 R71 U7 L72],
        ~w[U62 R66 U55 R34 D71 R55 D58 R83]
      ]

      assert 610 == AOC2019.Q3.p2(ops_list)
    end

    test "example 3" do
      ops_list = [
        ~w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51],
        ~w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7]
      ]

      assert 410 == AOC2019.Q3.p2(ops_list)
    end

    test "solve" do
      assert 19242 == AOC2019.Q3.input() |> AOC2019.Q3.p2()
    end
  end
end
