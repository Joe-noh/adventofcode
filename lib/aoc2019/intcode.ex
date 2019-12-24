defmodule AOC2019.Intcode do
  defstruct [:map, :pointer, :inputs, :outputs, :relative_base]

  def new(codes) do
    %__MODULE__{map: code_map(codes), pointer: 0, inputs: [], outputs: [], relative_base: 0}
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

  def input(struct, inputs) when is_list(inputs) do
    %__MODULE__{struct | inputs: inputs}
  end

  def input(struct, input) do
    %__MODULE__{struct | inputs: [input]}
  end

  defp do_calc(state = %{map: map, pointer: pointer, inputs: inputs, outputs: outputs, relative_base: relative_base}) do
    case next_operation(state) do
      {1, mode1, mode2, mode3, args = [arg1, arg2, output_pos]} ->
        value = mode_value(state, mode1, arg1) + mode_value(state, mode2, arg2)
        address = mode_value(state, mode3, output_pos)
        map = Map.put(map, address, value)

        do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1})

      {2, mode1, mode2, mode3, args = [arg1, arg2, output_pos]} ->
        value = mode_value(state, mode1, arg1) * mode_value(state, mode2, arg2)
        address = mode_value(state, mode3, output_pos)
        map = Map.put(map, address, value)

        do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1})

      {3, mode1, _mode2, _mode3, args = [output_pos]} ->
        [input_value | inputs] = inputs
        address = mode_value(state, mode1, output_pos)
        map = Map.put(map, address, input_value)

        do_calc(%__MODULE__{state | map: map, pointer: pointer + length(args) + 1, inputs: inputs})

      {4, mode1, _mode2, _mode3, args = [arg1]} ->
        case mode_value(state, mode1, arg1) do
          0 -> do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1})
          output -> do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1, outputs: [output | outputs]})
        end

      {5, mode1, mode2, _mode3, args = [arg1, output_pos]} ->
        case mode_value(state, mode1, arg1) do
          0 -> do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1})
          _ -> do_calc(%__MODULE__{state | pointer: mode_value(state, mode2, output_pos)})
        end

      {6, mode1, mode2, _mode3, args = [arg1, output_pos]} ->
        case mode_value(state, mode1, arg1) do
          0 -> do_calc(%__MODULE__{state | pointer: mode_value(state, mode2, output_pos)})
          _ -> do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1})
        end

      {7, mode1, mode2, mode3, args = [arg1, arg2, output_pos]} ->
        address = mode_value(state, mode3, output_pos)
        value = if mode_value(state, mode1, arg1) < mode_value(state, mode2, arg2), do: 1, else: 0

        do_calc(%__MODULE__{state | map: Map.put(map, address, value), pointer: pointer + length(args) + 1})

      {8, mode1, mode2, mode3, args = [arg1, arg2, output_pos]} ->
        address = mode_value(state, mode3, output_pos)
        value = if mode_value(state, mode1, arg1) == mode_value(state, mode2, arg2), do: 1, else: 0

        do_calc(%__MODULE__{state | map: Map.put(map, address, value), pointer: pointer + length(args) + 1})

      {9, mode1, _mode2, _mode3, args = [arg1]} ->
        relative_base = relative_base + mode_value(state, mode1, arg1)
        do_calc(%__MODULE__{state | pointer: pointer + length(args) + 1, relative_base: relative_base})

      {99, _, _, _, []} ->
        case outputs do
          [output | _] ->
            IO.inspect {output, Map.get(map, 0)}

          [] -> Map.get(map, 0)
        end
    end
  end

  defp next_operation(%{map: map, pointer: pointer}) do
    op = Map.get(map, pointer, 0)

    [_, mode3, mode2, mode1 | opcode] = Integer.digits(op + 100000)
    opcode = Integer.undigits(opcode)
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
  defp arguments(9, map, pointer), do: fetch_arguments(1, map, pointer)
  defp arguments(99, _map, _pointer), do: []

  defp fetch_arguments(n, map, pointer) do
    Enum.map(1..n, fn i -> Map.get(map, pointer + i, 0) end)
  end

  defp mode_value(%{map: map}, 0, arg), do: Map.get(map, arg, 0)
  defp mode_value(_state, 1, arg), do: arg
  defp mode_value(%{map: map, relative_base: base}, 2, arg), do: Map.get(map, arg, 0) + base
end
