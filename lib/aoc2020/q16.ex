defmodule AOC2020.Q16 do
  def p1(lines) do
    %{fields: fields, tickets: tickets} = parse_input(lines)

    tickets
    |> Enum.map(fn ticket ->
      ticket
      |> Enum.filter(fn number ->
        invalid_value_for_any_field?(number, fields)
      end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def p2(lines) do
    %{fields: fields, my_ticket: my_ticket, tickets: tickets} = parse_input(lines)

    valid_tickets =
      tickets
      |> Enum.filter(fn ticket ->
        Enum.all?(ticket, fn number ->
          not invalid_value_for_any_field?(number, fields)
        end)
      end)

    fields
    |> Enum.map(fn {_class, [range1, range2]} ->
      0..map_size(fields)
      |> Enum.filter(fn i ->
        Enum.all?(valid_tickets, fn ticket ->
          n = Enum.at(ticket, i)
          n in range1 or n in range2
        end)
      end)
    end)
    |> converge_index()
    |> Enum.zip(fields)
    |> Enum.filter(fn {_, {class, _ranges}} -> class |> String.starts_with?("departure") end)
    |> Enum.map(fn {index, _field} -> Enum.at(my_ticket, index) end)
    |> Enum.reduce(fn a, b -> a * b end)
  end

  defp parse_input(lines) do
    map = %{
      fields: %{},
      my_ticket: nil,
      tickets: []
    }

    lines
    |> Enum.reduce({:fields, map}, fn
      "", acc ->
        acc

      "your ticket:", {_, map} ->
        {:my_ticket, map}

      "nearby tickets:", {_, map} ->
        {:tickets, map}

      line, {:fields, map} ->
        {class, ranges} = parse_field_line(line)
        map = Map.update!(map, :fields, fn fields -> Map.put(fields, class, ranges) end)
        {:fields, map}

      line, {:my_ticket, map} ->
        numbers = line |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
        map = Map.put(map, :my_ticket, numbers)
        {:my_ticket, map}

      line, {:tickets, map} ->
        numbers = line |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
        map = Map.update!(map, :tickets, fn tickets -> [numbers | tickets] end)
        {:tickets, map}
    end)
    |> elem(1)
  end

  defp parse_field_line(line) do
    [_whole, class | ranges] = Regex.run(~r/\A(.+): (.+) or (.+)\z/, line)
    ranges = Enum.map(ranges, fn range ->
      [min, max] = range |> String.split("-") |> Enum.map(&String.to_integer/1)
      Range.new(min, max)
    end)

    {class, ranges}
  end

  defp invalid_value_for_any_field?(number, fields) do
    Enum.all?(fields, fn {_class, [range1, range2]} ->
      number not in range1 and number not in range2
    end)
  end

  defp converge_index(indexes_list) do
    indexes_list
    |> Enum.find(fn indexes -> is_list(indexes) && length(indexes) == 1 end)
    |> case do
      nil ->
        indexes_list

      [n] ->
        indexes_list
        |> Enum.map(fn
          x when not is_list(x) -> x
          [^n] -> n
          indexes -> indexes -- [n]
        end)
        |> converge_index()
    end
  end
end
