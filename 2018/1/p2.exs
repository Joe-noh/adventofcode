defmodule Day1 do
  def run do
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
