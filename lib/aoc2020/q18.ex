defmodule AOC2020.Q18 do
  def p1(lines) do
    lines
    |> Enum.map(&process1/1)
    |> Enum.sum()
  end

  def p2(lines) do
    lines
    |> Enum.map(&process2/1)
    |> Enum.sum()
  end

  defp process1(expr) do
    {list, ""} = expr |> parse_expr()

    calculate1(list)
  end

  defp process2(expr) do
    {list, ""} = expr |> parse_expr()

    calculate2(list)
  end

  defp parse_expr(expr) do
    parse_expr(expr, [])
  end

  defp parse_expr("(" <> rest, acc) do
    {parsed, rest} = parse_expr(rest)

    parse_expr(rest, [parsed | acc])
  end

  defp parse_expr(")" <> expr, acc) do
    {Enum.reverse(acc), expr}
  end

  defp parse_expr("+" <> expr, acc) do
    parse_expr(expr, ["+" | acc])
  end

  defp parse_expr("*" <> expr, acc) do
    parse_expr(expr, ["*" | acc])
  end

  defp parse_expr(" " <> expr, acc) do
    parse_expr(expr, acc)
  end

  defp parse_expr("", acc) do
    {Enum.reverse(acc), ""}
  end

  defp parse_expr(expr, acc) do
    [n, rest] =
      expr
      |> String.split(~r/\d+/, parts: 2, include_captures: true, trim: true)
      |> case do
        [n, rest] -> [n, rest]
        [n] -> [n, ""]
      end

    parse_expr(rest, [String.to_integer(n) | acc])
  end

  defp calculate1(number) when is_number(number) do
    number
  end

  defp calculate1(list) when is_list(list) do
    [head | tail] = list

    calculate1(tail, calculate1(head))
  end

  defp calculate1(["+", b | rest], acc) do
    calculate1(rest, acc + calculate1(b))
  end

  defp calculate1(["*", b | rest], acc) do
    calculate1(rest, acc * calculate1(b))
  end

  defp calculate1([], acc) do
    acc
  end

  defp calculate2(number) when is_number(number) do
    number
  end

  defp calculate2(list) when is_list(list) do
    [head | tail] = list

    calculate2(tail, calculate2(head), [])
  end

  defp calculate2(["+", b | rest], acc, muls) do
    calculate2(rest, acc + calculate2(b), muls)
  end

  defp calculate2(["*", b | rest], acc, muls) do
    calculate2(rest, calculate2(b), [acc | muls])
  end

  defp calculate2([], acc, []) do
    acc
  end

  defp calculate2([], acc, muls) do
    acc * Enum.reduce(muls, fn a, b -> a*b end)
  end
end
