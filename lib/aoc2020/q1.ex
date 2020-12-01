defmodule AOC2020.Q1 do
  def p1(list) do
    find_sum_pair(list, 2020) |> product()
  end

  def p2(list = [_ | tail]) do
    Enum.reduce_while(list, tail, fn num, acc ->
      case find_sum_pair(acc, 2020 - num) do
        nil -> {:cont, tl(acc)}
        {x, y} -> {:halt, {num, x, y}}
      end
    end)
    |> product()
  end

  defp find_sum_pair(list, sum) do
    set = MapSet.new(list)

    Enum.reduce_while(list, set, fn num, acc ->
      if MapSet.member?(acc, sum - num) do
        {:halt, {num, (sum - num)}}
      else
        next = MapSet.delete(acc, num)

        if MapSet.size(next) == 0 do
          {:halt, nil}
        else
          {:cont, MapSet.delete(acc, num)}
        end
      end
    end)
  end

  defp product(tuple) do
    tuple
    |> Tuple.to_list()
    |> Enum.reduce(fn a, b -> a * b end)
  end
end
