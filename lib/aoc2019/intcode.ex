defmodule AOC2019.Intcode do
  defstruct [:map, :pointer, :input]

  def new(codes) do
    %__MODULE__{map: code_map(codes), pointer: 0}
  end

  defp code_map(codes) do
    codes
    |> Enum.with_index()
    |> Enum.map(fn {e, i} -> {i, e} end)
    |> Enum.into(%{})
  end

  def calc(struct) do
    struct |> do_calc()
  end

  def replace(struct = %{map: map}, {month, day}) do
    map =
      map
      |> Map.put(1, month)
      |> Map.put(2, day)

    %__MODULE__{struct | map: map}
  end

  def input(struct, input) do
    %__MODULE__{struct | input: input}
  end

  defp do_calc(state = %{map: map, pointer: pointer, input: input}) do
    case next_operation(state) do
      {1, mode1, mode2, _mode3, args = [arg1, arg2, output_pos]} ->
        value = mode_value(map, mode1, arg1) + mode_value(map, mode2, arg2)
        map = Map.put(map, output_pos, value)

        do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1})

      {2, mode1, mode2, _mode3, args = [arg1, arg2, output_pos]} ->
        value = mode_value(map, mode1, arg1) * mode_value(map, mode2, arg2)
        map = Map.put(map, output_pos, value)

        do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1})

      {3, _mode1, _mode2, _mode3, args = [output_pos]} ->
        map = Map.put(map, output_pos, input)

        do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1})

      {4, mode1, _mode2, _mode3, args = [arg1]} ->
        case mode_value(map, mode1, arg1) do
          0 -> do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1})
          answer -> answer
        end

      {5, mode1, mode2, _mode3, args = [arg1, output_pos]} ->
        case mode_value(map, mode1, arg1) do
          0 -> do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1})
          _ -> do_calc(%__MODULE__{state | map: map, pointer: mode_value(map, mode2, output_pos)})
        end

      {6, mode1, mode2, _mode3, args = [arg1, output_pos]} ->
        case mode_value(map, mode1, arg1) do
          0 -> do_calc(%__MODULE__{state | map: map, pointer: mode_value(map, mode2, output_pos)})
          _ -> do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1})
        end

      {7, mode1, mode2, _mode3, args = [arg1, arg2, output_pos]} ->
        if mode_value(map, mode1, arg1) < mode_value(map, mode2, arg2) do
          do_calc(%__MODULE__{state | map: Map.put(map, output_pos, 1), pointer: pointer + length(args) + 1})
        else
          do_calc(%__MODULE__{state | map: Map.put(map, output_pos, 0), pointer: pointer + length(args) + 1})
        end

      {8, mode1, mode2, _mode3, args = [arg1, arg2, output_pos]} ->
        if mode_value(map, mode1, arg1) == mode_value(map, mode2, arg2) do
          do_calc(%__MODULE__{state | map: Map.put(map, output_pos, 1), pointer: pointer + length(args) + 1})
        else
          do_calc(%__MODULE__{state | map: Map.put(map, output_pos, 0), pointer: pointer + length(args) + 1})
        end

      {99, _, _, _, []} ->
        Map.get(map, 0)
    end
  end

  defp next_operation(%{map: map, pointer: pointer}) do
    op = Map.get(map, pointer)

    mode3 = div(op, 10000)
    mode2 = div(rem(op, 10000), 1000)
    mode1 = div(rem(op, 1000), 100)
    opcode = rem(op, 100)

    args = arguments(opcode, map, pointer)

    {opcode, mode1, mode2, mode3, args}
  end

  defp arguments(1, map, pointer), do: fetch_arguments(3, map, pointer)
  defp arguments(2, map, pointer), do: fetch_arguments(3, map, pointer)
  defp arguments(3, map, pointer), do: fetch_arguments(1, map, pointer)
  defp arguments(4, map, pointer), do: fetch_arguments(1, map, pointer)
  defp arguments(5, map, pointer), do: fetch_arguments(2, map, pointer)
  defp arguments(6, map, pointer), do: fetch_arguments(2, map, pointer)
  defp arguments(7, map, pointer), do: fetch_arguments(3, map, pointer)
  defp arguments(8, map, pointer), do: fetch_arguments(3, map, pointer)
  defp arguments(99, _map, _pointer), do: []

  defp fetch_arguments(n, map, pointer) do
    Enum.map(1..n, fn i -> Map.get(map, pointer + i) end)
  end

  defp mode_value(map, 0, arg), do: Map.get(map, arg)
  defp mode_value(_map, 1, arg), do: arg
end
