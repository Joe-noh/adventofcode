defmodule AOC2019.Q4 do
  def input do
    "265275-781584"
  end

  def p1(from, to) do
    Enum.count(from .. to, fn n ->
      digits = digit_integers(n)

      never_decrease?(digits) and have_same_adjacents?(digits)
    end)
  end

  def p2(from, to) do
    Enum.count(from .. to, fn n ->
      digits = digit_integers(n)

      never_decrease?(digits) and have_exact_two_adjacents?(digits)
    end)
  end

  defp digit_integers(n) do
    n
    |> to_string()
    |> String.codepoints()
    |> Enum.map(fn s -> Integer.parse(s) |> elem(0) end)
  end

  defp never_decrease?([a, b, c, d, e, f]) when a <= b and b <= c and c <= d and d <= e and e <= f, do: true
  defp never_decrease?(_), do: false

  defp have_same_adjacents?([a, a, _, _, _, _]), do: true
  defp have_same_adjacents?([_, a, a, _, _, _]), do: true
  defp have_same_adjacents?([_, _, a, a, _, _]), do: true
  defp have_same_adjacents?([_, _, _, a, a, _]), do: true
  defp have_same_adjacents?([_, _, _, _, a, a]), do: true
  defp have_same_adjacents?(_), do: false

  defp have_exact_two_adjacents?([]), do: false

  defp have_exact_two_adjacents?(digits = [head | _]) do
    {adjacents, rest} = Enum.split_while(digits, fn n -> n == head end)

    case length(adjacents) do
      2 -> true
      _ -> have_exact_two_adjacents?(rest)
    end
  end
end
