defmodule AOC2020.Q3 do
  def p1(lines) do
    count_encountered_trees(lines, {3, 1})
  end

  def p2(lines) do
    [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2},
    ]
    |> Enum.map(fn direction -> count_encountered_trees(lines, direction) end)
    |> Enum.reduce(fn a, b -> a * b end)
  end

  defp count_encountered_trees(lines = [head | _], {dx, dy}) do
    width = String.length(head)
    height = length(lines)

    {_, count} =
      Enum.reduce_while(2..height, {{dx, dy}, 0}, fn _, {{x, y}, count} ->
        if y >= height do
          {:halt, {nil, count}}
        else
          next = {rem(x+dx, width), y+dy}
          if Enum.at(lines, y) |> String.at(x) == "#" do # optimizable
            {:cont, {next, count+1}}
          else
            {:cont, {next, count}}
          end
        end
      end)

    count
  end
end
