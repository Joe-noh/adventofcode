defmodule AOC2019.Q2 do
  def p1 do
    AOC.Input.read!(2019, 2)
    |> String.split(",")
    |> Enum.map(&parse_int/1)
    |> prepare_program({12, 2})
    |> calc_intcode()
  end

  def p2 do
    codes =
      AOC.Input.read!(2019, 2)
      |> String.split(",")
      |> Enum.map(&parse_int/1)

    # bruteforce
    pairs = for month <- 0..99, day <- 0..99, into: [], do: {month, day}

    {noun, verb} = Enum.find(pairs, fn pair ->
      19690720 == codes |> prepare_program(pair) |> calc_intcode()
    end)

    noun * 100 + verb
  end

  defp parse_int(str) do
    str |> Integer.parse() |> elem(0)
  end

  defp prepare_program(codes, {month, day}) do
    codes
    |> List.replace_at(1, month)
    |> List.replace_at(2, day)
  end

  defp calc_intcode(codes) do
    do_calc_intcode(codes, 0)
  end

  defp do_calc_intcode(codes, opscode_position) do
    [opscode, pos1, pos2, output_pos] = Enum.slice(codes, opscode_position, 4)

    case opscode do
      1 ->
        codes
        |> List.replace_at(output_pos, Enum.at(codes, pos1) + Enum.at(codes, pos2))
        |> do_calc_intcode(opscode_position + 4)

      2 ->
        codes
        |> List.replace_at(output_pos, Enum.at(codes, pos1) * Enum.at(codes, pos2))
        |> do_calc_intcode(opscode_position + 4)

      99 ->
        codes |> hd()
    end
  end
end
