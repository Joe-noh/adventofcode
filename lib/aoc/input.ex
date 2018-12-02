defmodule AOC.Input do
  def read!(year, num) do
    File.read!("priv/inputs/#{year}/#{num}.txt")
  end
end
