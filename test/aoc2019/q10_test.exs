defmodule AOC2019.Q10Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      asteroids = ~w[
        ......#.#.
        #..#.#....
        ..#######.
        .#.#.###..
        .#..#.....
        ..#....#.#
        #..#....#.
        .##.#..###
        ##...#..#.
        .#....####
      ]

      assert AOC2019.Q10.p1(asteroids) == 33
    end

    test "example 2" do
      asteroids = ~w[
        #.#...#.#.
        .###....#.
        .#....#...
        ##.#.#.#.#
        ....#.#.#.
        .##..###.#
        ..#...##..
        ..##....##
        ......#...
        .####.###.
      ]

      assert AOC2019.Q10.p1(asteroids) == 35
    end


    test "example 3" do
      asteroids = ~w[
        .#..#..###
        ####.###.#
        ....###.#.
        ..###.##.#
        ##.##.#.#.
        ....###..#
        ..#.#..#.#
        #..#.#.###
        .##...##.#
        .....#.#..
      ]

      assert AOC2019.Q10.p1(asteroids) == 41
    end


    test "example 4" do
      asteroids = ~w[
        .#..##.###...#######
        ##.############..##.
        .#.######.########.#
        .###.#######.####.#.
        #####.##.#.##.###.##
        ..#####..#.#########
        ####################
        #.####....###.#.#.##
        ##.#################
        #####.##.###..####..
        ..######..##.#######
        ####.##.####...##..#
        .#####..#.######.###
        ##...#.##########...
        #.##########.#######
        .####.#.###.###.#.##
        ....##.##.###..#####
        .#.#.###########.###
        #.#.#.#####.####.###
        ###.##.####.##.#..##
      ]

      assert AOC2019.Q10.p1(asteroids) == 210
    end

    test "solve" do
      assert input() |> AOC2019.Q10.p1() == 344
    end
  end

  describe "part 2" do
    test "example 4" do
      asteroids = ~w[
        .#..##.###...#######
        ##.############..##.
        .#.######.########.#
        .###.#######.####.#.
        #####.##.#.##.###.##
        ..#####..#.#########
        ####################
        #.####....###.#.#.##
        ##.#################
        #####.##.###..####..
        ..######..##.#######
        ####.##.####...##..#
        .#####..#.######.###
        ##...#.##########...
        #.##########.#######
        .####.#.###.###.#.##
        ....##.##.###..#####
        .#.#.###########.###
        #.#.#.#####.####.###
        ###.##.####.##.#..##
      ]

      assert AOC2019.Q10.p2(asteroids) == 802
    end

    test "solve" do
      assert input() |> AOC2019.Q10.p2() == 2732
    end
  end

  def input do
    AOC.Input.read!(2019, 10) |> String.split()
  end
end