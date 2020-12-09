defmodule AOC2020.Q9 do
  def p1(list) do
    find_invalid_number(list)
  end

  def p2(list) do
    invalid_number = find_invalid_number(list)

    list
    |> find_contiguous_part(invalid_number)
    |> Enum.min_max()
    |> Tuple.to_list()
    |> Enum.sum()
  end

  defp find_invalid_number(list) do
    size = length(list)
    preambles_size = 25

    0..(size - preambles_size - 1)
    |> Enum.reduce([], fn index, acc ->
      [n | preambles] =
        list
        |> Enum.slice(index, preambles_size + 1)
        |> Enum.reverse()

      [{n, preambles} | acc]
    end)
    |> Enum.find(fn {n, preambles} ->
      not sum_of_two_preambles?(n, preambles)
    end)
    |> elem(0)
  end

  defp sum_of_two_preambles?(n, [head | tail]) do
    if (n - head) in tail do
      true
    else
      sum_of_two_preambles?(n, tail)
    end
  end

  defp sum_of_two_preambles?(_, []) do
    false
  end

  defp find_contiguous_part(list, sum) do
    last_index = length(list) - 1

    0..last_index
    |> Enum.find_value(fn i ->
      Enum.slice(list, i, last_index)
      |> detect_contiguous_part([], sum)
      |> case do
        {:error, :not_found} -> nil
        {:ok, contiguous} -> contiguous
      end
    end)
  end

  defp detect_contiguous_part([], _acc, _sum) do
    {:error, :not_found}
  end

  defp detect_contiguous_part([head | tail], acc, sum) do
    if Enum.sum([head | acc]) == sum do
      {:ok, [head | acc]}
    else
      detect_contiguous_part(tail, [head | acc], sum)
    end
  end
end
