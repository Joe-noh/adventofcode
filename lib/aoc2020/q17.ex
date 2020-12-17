defmodule AOC2020.Q17 do
  def p1(lines) do
    space = build_space(lines, 3)
    initial_edge = floor(length(lines) / 2)

    1..6
    |> Enum.map(fn i ->
      edge = initial_edge + i
      z_edge = i
      {-edge..edge, -edge..edge, -z_edge..z_edge}
    end)
    |> Enum.reduce(space, fn area, acc -> run(acc, area) end)
    |> Map.values()
    |> Enum.count(fn cube -> cube == "#" end)
  end

  def p2(lines) do
    space = build_space(lines, 4)
    initial_edge = floor(length(lines) / 2)

    1..6
    |> Enum.map(fn i ->
      edge = initial_edge + i
      z_edge = w_edge = i
      {-edge..edge, -edge..edge, -z_edge..z_edge, -w_edge..w_edge}
    end)
    |> Enum.reduce(space, fn area, acc -> run(acc, area) end)
    |> Map.values()
    |> Enum.count(fn cube -> cube == "#" end)
  end

  defp build_space(lines, dim) do
    len = length(lines)
    offset = -1 * floor(len / 2)

    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, x}, map ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(map, fn {cube, y}, acc ->
        case dim do
          3 -> acc |> Map.put({x + offset, y + offset, 0}, cube)
          4 -> acc |> Map.put({x + offset, y + offset, 0, 0}, cube)
        end
      end)
    end)
  end

  defp run(space, {x_range, y_range, z_range}) do
    list = for x <- x_range, y <- y_range, z <- z_range do
      update_cube(space, {x, y, z})
    end

    list |> Enum.into(%{})
  end

  defp run(space, {x_range, y_range, z_range, w_range}) do
    list = for x <- x_range, y <- y_range, z <- z_range, w <- w_range do
      update_cube(space, {x, y, z, w})
    end

    list |> Enum.into(%{})
  end

  defp update_cube(space, pos) do
    cube = Map.get(space, pos, ".")
    neighbors = neighbors(space, pos)
    active_neighbors_count = neighbors |> Enum.count(fn cube -> cube == "#" end)

    case {cube, active_neighbors_count} do
      {"#", count} when count in [2, 3] ->
        {pos, "#"}

      {"#", _} ->
        {pos, "."}

      {".", 3} ->
        {pos, "#"}

      {".", _} ->
        {pos, "."}
    end
  end

  defp neighbors(space, {x, y, z}) do
    for dx <- -1..1, dy <- -1..1, dz <- -1..1, {dx, dy, dz} != {0, 0, 0} do
      Map.get(space, {x + dx, y + dy, z + dz}, ".")
    end
  end

  defp neighbors(space, {x, y, z, w}) do
    for dx <- -1..1, dy <- -1..1, dz <- -1..1, dw <- -1..1, {dx, dy, dz, dw} != {0, 0, 0, 0} do
      Map.get(space, {x + dx, y + dy, z + dz, w + dw}, ".")
    end
  end
end
