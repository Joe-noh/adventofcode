defmodule AOC2020.Q6 do
  def p1(lines) do
    lines
    |> parse_answers_lines()
    |> Enum.map(fn answers ->
      answers
      |> Enum.join()
      |> unique_chars_set()
      |> MapSet.size()
    end)
    |> Enum.sum()
  end

  def p2(lines) do
    lines
    |> parse_answers_lines()
    |> Enum.map(fn answers ->
      people_count = length(answers)

      answers
      |> Enum.map(fn answer ->
        answer
        |> String.codepoints()
        |> Enum.reduce(%{}, fn char, map ->
          Map.put_new(map, char, 1)
        end)
      end)
      |> Enum.reduce(fn m1, m2 ->
        Map.merge(m1, m2, fn _k, v1, v2 -> v1 + v2 end)
      end)
      |> Enum.count(fn {_k, v} -> v == people_count end)
    end)
    |> Enum.sum()
  end

  defp parse_answers_lines(lines) do
    lines
    |> Enum.chunk_by(fn e -> e == "" end)
    |> Enum.reduce([], fn
      ["" | _], acc ->
        acc

      attrs, acc ->
        [attrs | acc]
    end)
    |> Enum.reverse()
  end

  defp unique_chars_set(str) do
    str
    |> String.codepoints()
    |> Enum.reduce(MapSet.new(), fn char, set ->
      MapSet.put(set, char)
    end)
  end
end
