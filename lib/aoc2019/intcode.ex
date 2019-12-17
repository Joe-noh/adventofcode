defmodule AOC2019.Intcode do
  defmodule State do
    defstruct [:codes, :map]

    def new(codes) do
      %__MODULE__{codes: codes, map: code_map(codes)}
    end

    defp code_map(codes) do
      codes
      |> Enum.with_index()
      |> Enum.map(fn {e, i} -> {i, e} end)
      |> Enum.into(%{})
    end
  end

  def calc(codes) do
    codes |> State.new() |> do_calc()
  end

  def calc(codes, {month, day}) do
    codes
    |> List.replace_at(1, month)
    |> List.replace_at(2, day)
    |> State.new()
    |> do_calc()
  end

  defp do_calc(state = %{codes: codes, map: map}) do
    case next_operation(codes) do
      {1, mode1, mode2, _mode3} ->
        [_op, arg1, arg2, output_pos | codes] = codes
        map = Map.put(map, output_pos, mode_value(map, mode1, arg1) + mode_value(map, mode2, arg2))

        do_calc(%State{state | codes: codes, map: map})

      {2, mode1, mode2, _mode3} ->
        [_op, arg1, arg2, output_pos | codes] = codes
        map = Map.put(map, output_pos, mode_value(map, mode1, arg1) * mode_value(map, mode2, arg2))

        do_calc(%State{state | codes: codes, map: map})

      {3, mode1, _mode2, _mode3} ->
        [_op, arg1 | codes] = codes
        map = Map.put(map, mode_value(map, mode1, arg1), 1)

        do_calc(%State{state | codes: codes, map: map})

      {4, mode1, _mode2, _mode3} ->
        [_op, arg1 | codes] = codes
        IO.puts(mode_value(map, mode1, arg1))

        do_calc(%State{state | codes: codes, map: map})

      {99, _, _, _} ->
        Map.get(map, 0)
    end
  end

  defp next_operation([op | _]) do
    mode3 = div(op, 10000)
    mode2 = div(rem(op, 10000), 1000)
    mode1 = div(rem(op, 1000), 100)
    opcode = rem(op, 100)

    IO.inspect {opcode, mode1, mode2, mode3}
  end

  defp mode_value(map, 0, arg), do: Map.get(map, arg)
  defp mode_value(_map, 1, arg), do: arg
end
