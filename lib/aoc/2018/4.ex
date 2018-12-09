defmodule AOC.Q4 do
  def part1 do
    {count_map, total_time_map} =
      AOC.Input.stream!(2018, 4)
      |> Stream.map(&parse_line/1)
      |> group_by_date()
      |> count_asleep_time()

    {most_asleep_guard, _total} =
      total_time_map
      |> Enum.max_by(fn {_id, minutes} -> minutes end)

    {{"#" <> most_asleep_guard_id, most_asleep_minute}, _count} =
      count_map
      |> Enum.filter(fn {{id, _minute}, _count} -> id == most_asleep_guard end)
      |> Enum.sort_by(fn {{_id, minute}, _} -> minute end)
      |> Enum.max_by(fn {_key, count} -> count end)

    String.to_integer(most_asleep_guard_id) * most_asleep_minute
  end

  def part2 do
    {count_map, _total_time_map} =
      AOC.Input.stream!(2018, 4)
      |> Stream.map(&parse_line/1)
      |> group_by_date()
      |> count_asleep_time()

    {{"#" <> most_asleep_guard_id, most_asleep_minute}, _count} =
      count_map
      |> Enum.max_by(fn {_key, count} -> count end)

    String.to_integer(most_asleep_guard_id) * most_asleep_minute
  end

  defp parse_line(line) do
    [[_whole, datetime_str, action]] = Regex.scan(~r/\[(.+)\] (.+)/, line)

    datetime = datetime_str |> parse_datetime()
    action = action |> parse_action()

    {datetime, action}
  end

  defp parse_datetime(datetime_str) do
    [year, month, day, hour, minute] =
      datetime_str
      |> String.split(~r/[:\s\-]/)
      |> Enum.map(&String.to_integer/1)

    NaiveDateTime.new(year, month, day, hour, minute, 0)
    |> elem(1)
    |> NaiveDateTime.add(3600)
  end

  defp parse_action(action) do
    case action do
      "falls asleep" -> :falls_asleep
      "wakes up" -> :wakes_up
      "Guard " <> shifted -> shifted |> String.split(" ") |> List.first
    end
  end

  defp group_by_date(records) do
    records
    |> Enum.group_by(fn {date, _action} -> {date.year, date.month, date.day} end)
    |> Enum.map(fn {_date_tuple, records} ->
      records
      |> Enum.sort_by(fn {date, _action} -> date end, &NaiveDateTime.compare(&1, &2) == :lt)
    end)
  end

  defp count_asleep_time(date_grouped_records) do
    date_grouped_records
    |> Enum.reduce({%{}, %{}}, fn day_records, {count_map, total_time_map} ->
      [{_date, guard} | actions] = day_records

      actions
      |> calc_asleep_ranges
      |> case do
        [] ->
          {count_map, total_time_map}
        asleep_ranges ->
          count_map =
            asleep_ranges
            |> Enum.flat_map(& Enum.into(&1, []))
            |> Enum.reduce(count_map, fn minute, acc ->
              Map.update(acc, {guard, minute}, 1, &(&1 + 1))
            end)
          minutes =
            asleep_ranges
            |> Enum.map(fn a..b -> b - a end)
            |> Enum.sum()
          total_time_map =
            total_time_map
            |> Map.update(guard, minutes, &(&1 + minutes))

          {count_map, total_time_map}
      end
    end)
  end

  defp calc_asleep_ranges(actions) do
    {:wakes_up, _minute, ranges} = Enum.reduce(actions, {:wakes_up, 0, []}, fn
      {date, :wakes_up}, {:falls_asleep, minute, asleep_ranges} ->
        {:wakes_up, date.minute, [minute..date.minute | asleep_ranges]}

      {date, :falls_asleep}, {:wakes_up, _minute, asleep_ranges} ->
        {:falls_asleep, date.minute, asleep_ranges}
    end)

    ranges
  end
end
