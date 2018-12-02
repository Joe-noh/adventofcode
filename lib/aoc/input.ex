defmodule AOC.Input do
  def read!(year, num) do
    path(year, num) |> File.read!()
  end

  def stream!(year, num) do
    path(year, num) |> File.stream!([], :line)
  end

  defp path(year, num) do
    "priv/inputs/#{year}/#{num}.txt"
  end
end
