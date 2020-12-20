defmodule AOC2020.Q19 do
  def p1(lines) do
    {rules, inputs} = lines |> parse_input()

    regex = ("^" <> Map.get(rules, "0") <> "$") |> Regex.compile!()

    inputs
    |> Enum.count(fn line -> Regex.match?(regex, line) end)
  end

  def p2(lines) do
    lines
  end

  defp parse_input(lines) do
    [rules, _, inputs | _] = Enum.chunk_by(lines, fn line -> line == "" end)

    rules =
      rules
      |> Enum.map(fn rule ->
        [key, rule] = String.replace(rule, "\"", "") |> String.split(": ")
        rule = String.split(rule, " ") |> Enum.join("  ")
        {key, " " <> rule <> " "}
      end)
      |> patterns()
      |> Enum.map(fn {k, v} -> {k, String.replace(v, " ", "")} end)
      |> Map.new()

    {rules, inputs}
  end

  defp patterns(rules, replaced \\ []) do
    replacements =
      rules
      |> Enum.filter(fn {_, v} -> v =~ ~r/\A[ab|\(\)\s]+\z/ end)
      |> Enum.filter(fn {k, _} -> not Enum.member?(replaced, k) end)

    if length(replacements) == 0 do
      rules
    else
      replacements
      |> Enum.reduce(rules, fn {char_key, char}, acc ->
        acc
        |> Enum.map(fn {k, v} ->
          {k, String.replace(v, " #{char_key} ", " (#{char}) ")}
        end)
      end)
      |> patterns(Enum.map(replacements, fn {k, _} -> k end) ++ replaced)
    end
  end
end
