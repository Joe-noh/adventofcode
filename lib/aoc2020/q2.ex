defmodule AOC2020.Q2 do
  def p1(list) do
    Enum.count(list, fn {min, max, char, password} ->
      valid_count_password?(password, {min, max}, char)
    end)
  end

  def p2(list) do
    Enum.count(list, fn {min, max, char, password} ->
      valid_position_password?(password, {min, max}, char)
    end)
  end

  defp valid_count_password?(password, range, char) do
    password
    |> String.codepoints()
    |> Enum.count(fn c -> c == char end)
    |> between?(range)
  end

  defp between?(num, {min, max}) do
    min <= num && num <= max
  end

  defp valid_position_password?(password, {p1, p2}, char) do
    xor(String.at(password, p1-1) == char, String.at(password, p2-1) == char)
  end

  defp xor(x, x), do: false
  defp xor(_x, _y), do: true
end
