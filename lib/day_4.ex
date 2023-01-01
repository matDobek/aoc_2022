defmodule Day4 do

  #
  # a/ 498
  # b/ 859
  #

  def solve do
    "./lib/day_4.input"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(&parse_group/1)
    |> Stream.filter(&valid_group?/1)
    |> Enum.into([])
    |> length()
  end

  defp parse_group(group) do
    group
    |> Enum.map(fn str ->
      [x, y] = str |> String.split("-") |> Enum.map(&String.to_integer/1)

      { x, y }
    end)
  end

  defp valid_group?([{x1, x2}, {y1, y2}]) when x1 in y1..y2 or x2 in y1..y2, do: true
  defp valid_group?([{x1, x2}, {y1, y2}]) when y1 in x1..x2 or y2 in x1..x2, do: true
  defp valid_group?(_), do: false
end
