defmodule AOC2020.Q7 do
  def p1(stream) do
    rules =
      stream
      |> parse_bag_rules()
      |> Stream.map(fn {container, containees} ->
        containees = Enum.map(containees, fn {_q, c} -> c end)
        {container, containees}
      end)
      |> Enum.into(%{})

    rules
    |> Enum.count(fn {_container, containees} ->
      containees |> has_descendant?("shiny gold", rules)
    end)
  end

  def p2(stream) do
    rules =
      stream
      |> parse_bag_rules()
      |> Enum.into(%{})

    count_bags_inside("shiny gold", rules)
  end

  defp parse_bag_rules(stream) do
    stream
    |> Stream.map(fn line -> line |> String.trim() |> String.split(" bags contain ") end)
    |> Stream.map(fn
      [container, "no " <> _] ->
        {container, []}
      [container, rules] ->
        contents =
          rules
          |> String.split(", ")
          |> Enum.map(fn content ->
            [quantity, c1, c2 | _] = content |> String.split(" ")

            {String.to_integer(quantity), "#{c1} #{c2}"}
          end)

        {container, contents}
    end)
  end

  defp has_descendant?([], _, _) do
    false
  end

  defp has_descendant?(containees, child, rules) do
    if child in containees do
      true
    else
      containees
      |> Enum.map(fn c -> Map.get(rules, c) end)
      |> Enum.filter(fn c -> not is_nil(c) end)
      |> List.flatten()
      |> has_descendant?(child, rules)
    end
  end

  defp count_bags_inside(color, rules) do
    Map.get(rules, color) |> do_count_bags_inside(rules)
  end

  defp do_count_bags_inside([], _rules) do
    1
  end

  defp do_count_bags_inside(containees, rules) do
    container_count =
      containees
      |> Enum.map(fn {q, c} ->
        case Map.get(rules, c) do
          [] -> 0
          _ -> q
        end
      end)
      |> Enum.sum()

    containees
    |> Enum.map(fn {quantity, color} -> quantity * count_bags_inside(color, rules) end)
    |> Enum.sum()
    |> Kernel.+(container_count)
  end
end
