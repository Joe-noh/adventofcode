defmodule AOC.Q2 do
  def part1 do
    %{2 => count2, 3 => count3} =
      AOC.Input.read!(2018, 2)
      |> String.split
      |> Enum.reduce(%{2 => 0, 3 => 0}, fn line, acc ->
        line
        |> count_chars()
        |> two_three_map()
        |> Enum.reduce(acc, fn
          {2, 1}, acc -> Map.update!(acc, 2, &(&1 + 1))
          {3, 1}, acc -> Map.update!(acc, 3, &(&1 + 1))
        end)
      end)

    IO.puts count2 * count3
  end

  def part2 do
    lines = AOC.Input.read!(2018, 2) |> String.split

    try do
      part2(lines)
    catch
      {line1, line2} ->
        chars1 = String.codepoints(line1)
        chars2 = String.codepoints(line2)

        Enum.zip(chars1, chars2)
        |> Enum.reduce([], fn
          {c, c}, acc -> [c | acc]
          {_, _}, acc -> acc
        end)
        |> Enum.reverse
        |> Enum.join
        |> IO.puts
    end
  end

  defp part2(lines) do
    Enum.reduce(lines, [], fn line1, one_diff_lines ->
      chars = String.codepoints(line1)
      boxes =
        Enum.reduce(lines, [], fn
          ^line1, one_diff_line -> one_diff_line
          line2, one_diff_line ->
            diff =
              chars
              |> Enum.zip(String.codepoints(line2))
              |> Enum.reduce(0, fn
                {c, c}, diff_count -> diff_count
                {_, _}, diff_count -> diff_count + 1
              end)

            if diff == 1 do
              [line2 | one_diff_line]
            else
              one_diff_line
            end
        end)

      if length(boxes) == 0 do
        one_diff_lines
      else
        throw {line1, List.first(boxes)}
      end
    end)
  end

  defp count_chars(str) do
    str
    |> String.codepoints()
    |> Enum.reduce(%{}, fn char, acc ->
      Map.update(acc, char, 1, fn n -> n + 1 end)
    end)
  end

  defp two_three_map(counts) do
    counts
    |> Enum.reduce(%{}, fn
      {_char, 2}, acc ->
        Map.put(acc, 2, 1)
      {_char, 3}, acc ->
        Map.put(acc, 3, 1)
      _other, acc ->
        acc
    end)
  end
end
