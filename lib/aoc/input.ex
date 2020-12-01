defmodule AOC.Input do
  def read!(year, num) do
    path(year, num) |> File.read!()
  end

  def read_as_numbers!(year, num) do
    path(year, num)
    |> File.read!()
    |> String.split()
    |> Enum.map(fn e -> Integer.parse(e) |> elem(0) end)
  end

  def stream!(year, num) do
    path(year, num) |> File.stream!([], :line)
  end

  defp path(year, num) do
    "priv/inputs/#{year}/#{num}.txt"
  end
end
