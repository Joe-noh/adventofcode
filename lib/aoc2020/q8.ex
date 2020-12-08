defmodule AOC2020.Q8 do
  def p1(lines) do
    {:loop, acc} = lines |> parse_operations() |> run({0, 0, MapSet.new})

    acc
  end

  def p2(lines) do
    lines |> parse_operations() |> fixed_operations_result()
  end

  defp parse_operations(lines) do
    {ops, _} = Enum.reduce(lines, {%{}, 0}, fn line, {acc, addr} ->
      [op, arg] = line |> String.trim() |> String.split(" ")
      arg = String.to_integer(arg)

      {Map.put(acc, addr, {op, arg}), addr + 1}
    end)

    ops
  end

  defp run(operations, initial) do
    eof = map_size(operations)

    1..1000000
    |> Enum.reduce_while(initial, fn _, {addr, acc, executeds} ->
      cond do
        addr == eof ->
          {:halt, {:terminate, acc}}

        MapSet.member?(executeds, addr) ->
          {:halt, {:loop, acc}}

        true ->
          executeds = MapSet.put(executeds, addr)

          case Map.get(operations, addr) do
            {"nop", _} ->
              next = {addr + 1, acc, executeds}
              {:cont, next}

            {"jmp", arg} ->
              next = {addr + arg, acc, executeds}
              {:cont, next}

            {"acc", arg} ->
              next = {addr + 1, acc + arg, executeds}
              {:cont, next}
          end
      end
    end)
  end

  def fixed_operations_result(operations) do
    1..1000000
    |> Enum.reduce_while({0, 0, MapSet.new}, fn _, {addr, acc, executeds} ->
      case Map.get(operations, addr) do
        {"nop", arg} ->
          operations
          |> Map.put(addr, {"jmp", arg})
          |> run({addr, acc, executeds})
          |> case do
            {:loop, _} ->
              next = {addr + 1, acc, MapSet.put(executeds, addr)}
              {:cont, next}
            {:terminate, acc} ->
              {:halt, acc}
          end

        {"jmp", arg} ->
          operations
          |> Map.put(addr, {"nop", arg})
          |> run({addr, acc, executeds})
          |> case do
            {:loop, _} ->
              next = {addr + arg, acc, MapSet.put(executeds, addr)}
              {:cont, next}
            {:terminate, acc} ->
              {:halt, acc}
          end
        {"acc", arg} ->
          next = {addr + 1, acc + arg, executeds}
          {:cont, next}
      end
    end)
  end
end
