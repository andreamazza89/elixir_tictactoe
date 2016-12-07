defmodule Game.Engine do

  def play({player_one_stream, player_one_mark}, {player_two_stream, player_two_mark}) do
    empty_board = %Board{}
    do_play({player_one_stream, player_one_mark}, {player_two_stream, player_two_mark}, empty_board)
  end

  defp do_play({current_player_stream, current_player_mark}, {next_player_stream, next_player_mark}, board) do
    case Board.status(board) do
      {:win, winner} ->
        UI.Console.announce_winner(winner)
      :draw ->
        UI.Console.announce_draw
      :incomplete ->
        parsed_move = UI.Console.get_next_move(board, current_player_stream, current_player_mark)
        updated_board = Board.add_move(board, parsed_move)
        do_play({next_player_stream, next_player_mark}, {current_player_stream, current_player_mark}, updated_board)
    end
  end

end
