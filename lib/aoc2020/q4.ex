defmodule AOC2020.Q4 do
  @required_fileds ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def p1(lines) do
    lines
    |> parse_passport_lines()
    |> Enum.count(&has_all_field?/1)
  end

  def p2(lines) do
    lines
    |> parse_passport_lines()
    |> Enum.count(fn passport ->
      has_all_field?(passport) && has_valid_fields?(passport)
    end)
  end

  defp parse_passport_lines(lines) do
    lines
    |> Enum.chunk_by(fn e -> e == "" end)
    |> Enum.reduce([], fn
      ["" | _], acc ->
        acc

      attrs, acc ->
        [parse_attrs(attrs) | acc]
    end)
    |> Enum.reverse()
  end

  defp parse_attrs(attrs) do
    attrs
    |> Enum.join(" ")
    |> String.split(" ")
    |> Enum.map(fn entry -> String.split(entry, ":") end)
    |> Enum.map(fn [k, v] -> {k, v} end)
    |> Map.new()
  end

  defp has_all_field?(attrs) do
    Enum.all?(@required_fileds, fn key ->
      Map.has_key?(attrs, key)
    end)
  end

  defp has_valid_fields?(attrs) do
    Enum.all?(attrs, fn
      {"byr", val} ->
        {n, ""} = Integer.parse(val)
        n in 1920 .. 2002

      {"iyr", val} ->
        {n, ""} = Integer.parse(val)
        n in 2010 .. 2020

      {"eyr", val} ->
        {n, ""} = Integer.parse(val)
        n in 2020 .. 2030

      {"hgt", val} ->
        case Integer.parse(val) do
          {n, "cm"} -> n in 150 .. 193
          {n, "in"} -> n in 59 .. 76
          _other -> false
        end

      {"hcl", val} ->
        val =~ ~r/^#[0-9a-f]{6}$/

      {"ecl", val} ->
        val in ~w[amb blu brn gry grn hzl oth]

      {"pid", val} ->
        val =~ ~r/^\d{9}$/

      {_k, _v} -> true
    end)
  end
end
