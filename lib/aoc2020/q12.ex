defmodule AOC2020.Q12 do
  def p1(lines) do
    initial = {{0, 0}, {1, 0}}

    {{x, y}, _} =
      lines
      |> Enum.reduce(initial, fn instruction, {{x, y}, {dx, dy}} ->
        instruction
        |> parse_instruction()
        |> move({x, y}, {dx, dy})
      end)

    manhattan_distance(x, y)
  end

  def p2(lines) do
    initial = {{0, 0}, {10, 1}}

    {{x, y}, _} =
      lines
      |> Enum.reduce(initial, fn instruction, {pos, waypoint} ->
        instruction
        |> parse_instruction()
        |> move_waypoint(pos, waypoint)
      end)

    manhattan_distance(x, y)
  end

  defp parse_instruction(instruction) do
    {c, n} = String.split_at(instruction, 1)

    {c, String.to_integer(n)}
  end

  defp move({"N", distance}, {x, y}, {dx, dy}) do
    {{x, y + distance}, {dx, dy}}
  end

  defp move({"S", distance}, {x, y}, {dx, dy}) do
    {{x, y - distance}, {dx, dy}}
  end

  defp move({"E", distance}, {x, y}, {dx, dy}) do
    {{x + distance, y}, {dx, dy}}
  end

  defp move({"W", distance}, {x, y}, {dx, dy}) do
    {{x - distance, y}, {dx, dy}}
  end

  defp move(instruction = {dir, _}, pos, {dx, dy}) when dir in ~w[L R] do
    {pos, rotate(instruction, {dx, dy})}
  end

  defp move({"F", distance}, {x, y}, {dx, dy}) do
    {{x + dx * distance, y + dy * distance}, {dx, dy}}
  end

  defp move_waypoint({"F", distance}, {x, y}, {dx, dy}) do
    {{x + dx * distance, y + dy * distance}, {dx, dy}}
  end

  defp move_waypoint(instruction = {dir, _}, {x, y}, waypoint) when dir in ~w[L R] do
    {{x, y}, rotate(instruction, waypoint)}
  end

  defp move_waypoint({dir, distance}, {x, y}, waypoint) do
    {waypoint, _} = move({dir, distance}, waypoint, {nil, nil})

    {{x, y}, waypoint}
  end

  defp rotate({"L", 90}, {dx, dy}) do
    {-dy, dx}
  end

  defp rotate({"R", 90}, {dx, dy}) do
    {dy, -dx}
  end

  defp rotate({lr, 180}, {dx, dy}) when lr in ["L", "R"] do
    {-dx, -dy}
  end

  defp rotate({"L", 270}, dir) do
    rotate({"R", 90}, dir)
  end

  defp rotate({"R", 270}, dir) do
    rotate({"L", 90}, dir)
  end

  defp manhattan_distance(x, y) do
    abs(x) + abs(y)
  end
end
