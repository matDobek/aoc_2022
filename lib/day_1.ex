defmodule Day1 do

  #
  # a/ 70764
  # b/ 203905
  #

  def solution, do: {solve_a(), solve_b()}

  defp solve_a do
    parse_input()
    |> top(1)
    |> Enum.sum()
  end

  defp solve_b do
    parse_input()
    |> top(3)
    |> Enum.sum()
  end

  defp top(collection, n), do: top(collection, n, [])
  defp top([], _, current_top), do: current_top
  defp top([x | xs], n, previous_top) do
    current_top = [x | previous_top]
      |> Enum.sort(:desc)
      |> Enum.take(n)

    top(xs, n, current_top)
  end

  defp parse_input do
    "./lib/day_1.input"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_by(&blank?/1)
    |> Stream.reject(fn [x | _] -> blank?(x)  end)
    |> Stream.map(&parse_group/1)
    |> Enum.into([])
  end

  defp parse_group(xs) do
    xs
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp blank?(nil), do: true
  defp blank?(x) when is_binary(x), do: x == ""
  defp blank?(_), do: false
end
