defmodule Day3 do

  #
  # a/ 8176
  # b/ 2689
  #

  def solve do
    parse_input()
    |> Stream.chunk_every(3)
    |> Stream.map(&find_duplicate/1)
    |> Stream.map(&score_for/1)
    |> Enum.into([])
    |> Enum.sum
  end

  # def find_duplicate([xs, ys, zs]) do
  #   xs = xs |> String.to_charlist() |> MapSet.new()
  #   ys = ys |> String.to_charlist() |> MapSet.new()
  #   zs = zs |> String.to_charlist() |> MapSet.new()
  #
  #   MapSet.intersection(xs, ys)
  #   |> MapSet.intersection(zs)
  #   |> MapSet.to_list()
  #   |> hd()
  # end

  def find_duplicate([<<x::utf8, xs::binary>>, ys, zs]) do
    case String.contains?(ys, <<x::utf8>>) && String.contains?(zs, <<x::utf8>>) do
      true -> x
      false -> find_duplicate([xs, ys, zs])
    end
  end

  defp score_for(n) do
    Enum.concat(?a..?z, ?A..?Z)
    |> Enum.zip(Stream.iterate(1, & &1 + 1))
    |> Map.new
    |> Map.fetch!(n)
  end

  defp parse_input do
    "./lib/day_3.input"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
