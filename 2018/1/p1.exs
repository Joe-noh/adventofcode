defmodule Day1 do
  def run do
    input()
    |> String.split
    |> calc()
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

  defp add("+" <> num, freq) do
    freq + String.to_integer(num)
  end

  defp add("-" <> num, freq) do
    freq - String.to_integer(num)
  end

  defp input do
    Path.join([__DIR__, "input"]) |> File.read!
  end
end

Day1.run
