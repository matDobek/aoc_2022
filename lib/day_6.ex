defmodule Day6 do

  #
  # a/ 1275
  # b/ 3605
  #

  def solve do
    input = parse_input("./lib/day_6.input")

    {
      find_marker(input, 4),
      find_marker(input, 14),
    }
  end

  def find_marker(input, marker_size, index \\ 0) do
    <<marker::binary-size(marker_size), _::binary>> = input
    <<_, new_input::binary>> = input

    all_unique = marker
      |> String.graphemes()
      |> MapSet.new()
      |> MapSet.size
      |> Kernel.==(marker_size)

    case all_unique do
      true -> {marker, index + marker_size}
      false -> find_marker(new_input, marker_size, index + 1)
    end
  end

  def parse_input(path) do
    path
    |> File.read!()
    |> String.trim()
  end
end
