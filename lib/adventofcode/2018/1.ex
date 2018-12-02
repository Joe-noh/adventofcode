defmodule Adventofcode.Q1 do
  def part1 do
    input()
    |> String.split
    |> calc()
  end

  def part2 do
    input()
    |> String.split
    |> Stream.cycle
    |> Enum.reduce(%{current: 0, history: %{}}, fn x, %{current: current, history: history} ->
      current = add(x, current)
      case Map.get(history, current) do
        nil ->
          %{current: current, history: Map.put(history, current, 1)}
        1 ->
          IO.puts current
          exit(:normal)
      end
    end)
  end

  defp calc(changes) do
    calc(changes, 0)
  end

  defp calc([head | tail], freq) do
    calc(tail, add(head, freq))
  end

  defp calc([], freq) do
    IO.puts freq
  end

  defp add("+" <> num, freq), do: freq + String.to_integer(num)
  defp add("-" <> num, freq), do: freq - String.to_integer(num)

  defp input do
    File.read!("priv/inputs/2018/1.txt")
  end
end
