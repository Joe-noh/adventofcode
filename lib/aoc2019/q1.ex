defmodule AOC2019.Q1 do
  def p1 do
    AOC.Input.stream!(2019, 1)
    |> Stream.map(&parse_int/1)
    |> Stream.map(&fuel_requirements/1)
    |> Enum.sum()
  end

  def p2 do
    AOC.Input.stream!(2019, 1)
    |> Stream.map(&parse_int/1)
    |> Stream.map(&recursive_fuel_requirements/1)
    |> Enum.sum()
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end

  defp fuel_requirements(mass) do
    div(mass, 3) - 2
  end

  defp recursive_fuel_requirements(mass) do
    recursive_fuel_requirements(mass, 0)
  end

  defp recursive_fuel_requirements(mass, sum) do
    case fuel_requirements(mass) do
      x when x <= 0 -> sum
      x -> recursive_fuel_requirements(x, sum + x)
    end
  end
end
