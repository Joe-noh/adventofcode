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

  defp do_calc(state = %{codes: [op, pos1, pos2, output_pos | codes], map: map}) do
    case op do
      1 ->
        map = Map.put(map, output_pos, Map.get(map, pos1) + Map.get(map, pos2))
        do_calc(%State{state | codes: codes, map: map})

      2 ->
        map = Map.put(map, output_pos, Map.get(map, pos1) * Map.get(map, pos2))
        do_calc(%State{state | codes: codes, map: map})

      99 ->
        Map.get(map, 0)
    end
  end
end
