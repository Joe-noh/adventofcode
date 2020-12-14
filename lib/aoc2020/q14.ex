defmodule AOC2020.Q14 do
  def p1(stream) do
    stream
    |> Stream.map(fn line -> line |> String.trim() |> parse_line() end)
    |> Enum.reduce({"", %{}}, fn
      {:mask, mask}, {_, mem} ->
        {mask, mem}

      {:write, addr, value}, {mask, mem} ->
        mem = Map.put(mem, addr, masked_value(value, mask))
        {mask, mem}
    end)
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  def p2(stream) do
    stream
    |> Stream.map(fn line -> line |> String.trim() |> parse_line() end)
    |> Enum.reduce({"", %{}}, fn
      {:mask, mask}, {_, mem} ->
        {mask, mem}

      {:write, addr, value}, {mask, mem} ->
        mem =
          masked_addrs(addr, mask)
          |> Enum.reduce(mem, fn addr, mem -> Map.put(mem, addr, value) end)

        {mask, mem}
    end)
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  defp parse_line("mask = " <> mask) do
    {:mask, mask}
  end

  defp parse_line(write = "mem" <> _) do
    [_, addr, value] = Regex.run(~r/\Amem\[(\d+)\] = (\d+)\z/, write)

    {:write, String.to_integer(addr), String.to_integer(value)}
  end

  defp masked_value(value, mask) do
    value
    |> Integer.to_string(2)
    |> String.pad_leading(36, "0")
    |> String.split("", trim: true)
    |> Enum.zip(mask |> String.split("", trim: true))
    |> Enum.reduce([], fn
      {v, "X"}, acc -> [v | acc]
      {_, m}, acc -> [m | acc]
    end)
    |> Enum.reverse()
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp masked_addrs(addr, mask) do
    addr
    |> Integer.to_string(2)
    |> String.pad_leading(36, "0")
    |> String.split("", trim: true)
    |> Enum.zip(mask |> String.split("", trim: true))
    |> Enum.reduce([], fn
      {_v, "X"}, acc -> ["X" | acc]
      {_v, "1"}, acc -> ["1" | acc]
      {v, "0"}, acc -> [v | acc]
    end)
    |> Enum.reverse()
    |> possible_addr_patterns()
  end

  defp possible_addr_patterns(addr_chars) do
    float_count = addr_chars |> Enum.count(fn c -> c == "X" end)
    possible_count = :math.pow(2, float_count) |> round()

    0..(possible_count - 1)
    |> Enum.map(fn n ->
      replacements =
        n
        |> Integer.to_string(2)
        |> String.pad_leading(float_count, "0")
        |> String.split("", trim: true)

      addr_chars
      |> Enum.reduce({replacements, []}, fn
        "X", {[r | rest], acc} -> {rest, [r | acc]}
        c, {replacements, acc} -> {replacements, [c | acc]}
      end)
      |> elem(1)
      |> Enum.reverse()
      |> Enum.join()
    end)
    |> Enum.map(fn addr -> addr |> String.to_integer(2) end)
  end
end
