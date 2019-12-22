defmodule AOC2019.Q8 do
  def p1(pixels) do
    fewest_zero =
      pixels
      |> Enum.chunk_every(25*6)
      |> Enum.min_by(fn layer ->
        Enum.count(layer, fn pixel -> pixel == "0" end)
      end)

    Enum.count(fewest_zero, &(&1 == "1")) * Enum.count(fewest_zero, &(&1 == "2"))
  end

  def p2(pixels) do
    pixels
    |> Enum.chunk_every(25*6)
    |> Enum.reduce(fn back, front ->
      Enum.zip(front, back)
      |> Enum.map(fn
        {"2", back_pixel} -> back_pixel
        {front_pixel, _} -> front_pixel
      end)
    end)
    |> print_image(25)
  end

  defp print_image(pixels, width) do
    pixels
    |> Enum.chunk_every(width)
    |> Enum.each(fn row ->
      Enum.each(row, fn pixel ->
        case pixel do
          "0" -> IO.write(" ")
          _ -> IO.write("X")
        end
      end)
      IO.puts ""
    end)
  end
end
