defmodule Combat do
  @moduledoc """
  This the solution to advent_of_code_2020 day 22 
  """

  def play(player1, player2) do
    %{winner: winner, winner_deck: deck} = run(player1, player2, 1)
    IO.puts("Winner: #{winner} Deck: #{deck_str(deck)} Score: #{score(deck)}")
  end

  defp deck_str(deck),
    do: "[#{Enum.join(deck, ",")}]"

  defp run(player1, [], _turn),
    do: %{winner: :player1, winner_deck: player1}

  defp run([], player2, _turn),
    do: %{winner: :player2, winner_deck: player2}

  # defp run(_player1, _player2, 100),
  #   do: %{winner: :deuce, winner_deck: []}

  defp run([card1 | deck1], [card2 | deck2], history) do
    IO.puts("MOVE: #{history}")
    IO.puts("PLAYS: Player1: #{card1}  Player2: #{card2}")
    IO.puts("DECK: Player1: #{deck_str(deck1)}  Player2: #{deck_str(deck2)}")
    IO.puts("------------------------------------------------------------")

    if card1 > card2 do
      run(deck1 ++ [card1, card2], deck2, history + 1)
    else
      run(deck1, deck2 ++ [card2, card1], history + 1)
    end
  end

  def score(deck) do
    deck
    |> Enum.reverse()
    |> Enum.reduce({1, 0}, fn card, {multiplier, total} -> {multiplier + 1, total + card * multiplier} end)
    |> elem(1)
  end
end

# {player1, player2} =
#   1..10
#   |> Enum.shuffle()
#   |> Enum.split(5)

player1 = [27, 29, 30, 44, 50, 5, 33, 47, 34, 38, 36, 4, 2, 18, 24, 16, 32, 21, 17, 9, 3, 22, 41, 31, 23]
player2 = [25, 1, 15, 46, 6, 13, 20, 12, 10, 14, 19, 37, 40, 26, 43, 11, 48, 45, 49, 28, 35, 7, 42, 39, 8]
Combat.play(player1, player2)
