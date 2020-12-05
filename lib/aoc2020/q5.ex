defmodule AOC2020.Q5 do
  def p1(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&calculate_seat_id/1)
    |> Enum.max()
  end

  def p2(stream) do
    all_seats = MapSet.new(0..1023)

    listed_seats =
      stream
      |> Stream.map(&String.trim/1)
      |> Stream.map(&calculate_seat_id/1)
      |> MapSet.new()

    MapSet.difference(all_seats, listed_seats)
    |> MapSet.to_list()
    |> Enum.sort()
    |> drop_very_front_and_back()
  end

  defp calculate_seat_id(seat) do
    seat
    |> String.replace("B", "1")
    |> String.replace("F", "0")
    |> String.replace("R", "1")
    |> String.replace("L", "0")
    |> String.to_integer(2)
  end

  def drop_very_front_and_back(seat_ids) do
    seat_ids
    |> do_drop_very_front_and_back()
    |> Enum.reverse()
    |> do_drop_very_front_and_back()
    |> List.first()
  end

  def do_drop_very_front_and_back([x, y | rest]) when abs(y - x) == 1 do
    do_drop_very_front_and_back([y | rest])
  end

  def do_drop_very_front_and_back([_x, y | rest]) do
    [y | rest]
  end
end
