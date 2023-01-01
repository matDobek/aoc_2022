defmodule Day5 do

  #
  # a/ VRWBSFZWM
  # b/ RBTWJWMCF
  #

  def solve do
    {crates, commands} = parse_input("./lib/day_5.input")

    {
      solve(9000, crates, commands) |> top_crates(),
      solve(9001, crates, commands) |> top_crates()
    }
  end

  defp solve(crane_model, crates, cmds) do
    Enum.reduce(cmds, crates, fn [amount, src, dst], acc ->
      {to_haul, to_leave} = Enum.split(acc[src], amount)

      new_dst = case crane_model do
        9000 -> ( to_haul |> Enum.reverse ) ++ acc[dst]
        9001 -> to_haul ++ acc[dst]
      end

      %{acc | src => to_leave, dst => new_dst}
    end)
  end

  defp top_crates(crates) do
    crates
    |> Enum.map(fn {_, [v | _]} -> v end)
  end

  defp parse_input(path) do
    {
      parse_crates(path),
      parse_commands(path)
    }
  end

  defp parse_crates(path) do
    path
    |> File.stream!()
    |> Stream.filter(&String.contains?(&1, "["))
    |> Stream.map(fn line ->
      line
      |> String.to_charlist
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.at(&1, 1))
      |> Enum.with_index(1)
    end)
    |> Enum.into([])
    |> List.flatten
    |> Enum.reject(fn {v, _} -> v == ?\s end)
    |> Enum.group_by(fn {_, i} -> i end, fn {v, _} -> v end)
  end

  defp parse_commands(path) do
    path
    |> File.stream!()
    |> Stream.filter(&String.contains?(&1, "move"))
    |> Stream.map(fn line ->
      Regex.scan(~r/\d+/, line)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.into([])
  end
end
