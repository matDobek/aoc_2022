defmodule Day2 do

  #
  # a/ 10816
  # b/ 11657
  #

  def solve do
    parse_input()
    |> Enum.map(&resolve/1)
    |> Enum.sum
  end

  defp resolve(<<a, " ", b>>) do
    match_result  = %{ ?X => :lose, ?Y => :draw, ?Z => :win} |> Map.fetch!(b)
    player_1_hand = %{ ?A => :rock, ?B => :paper, ?C => :scissors } |> Map.fetch!(a)
    player_2_hand = case match_result do
      :win -> counter_for(player_1_hand)
      :draw -> player_1_hand
      :lose -> yield_for(player_1_hand)
    end

    points_for(match_result) + points_for(player_2_hand)
  end

  defp counter_for(:rock), do: :paper
  defp counter_for(:paper), do: :scissors
  defp counter_for(:scissors), do: :rock

  defp yield_for(:rock), do: :scissors
  defp yield_for(:paper), do: :rock
  defp yield_for(:scissors), do: :paper

  defp points_for(:rock), do: 1
  defp points_for(:paper), do: 2
  defp points_for(:scissors), do: 3
  defp points_for(:lose), do: 0
  defp points_for(:draw), do: 3
  defp points_for(:win), do: 6

  defp parse_input do
    "./lib/day_2.input"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.into([])
  end
end
