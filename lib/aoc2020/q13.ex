defmodule AOC2020.Q13 do
  def p1(input) do
    {timestamp, bus_ids} = input |> parse_input()

    {id, minutes} =
      bus_ids
      |> Enum.map(fn id -> {id, id - rem(timestamp , id)} end)
      |> Enum.min_by(fn {_id, diff} -> diff end)

    id * minutes
  end

  defp parse_input([depart_timestamp, bus_ids]) do
    timestamp = String.to_integer(depart_timestamp)
    bus_ids =
      bus_ids
      |> String.split(",")
      |> Enum.filter(fn id -> id != "x" end)
      |> Enum.map(fn id -> String.to_integer(id) end)

    {timestamp, bus_ids}
  end
end
