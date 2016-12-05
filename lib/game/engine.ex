defmodule Game.Engine do

  #hello side effects!
  def next_move(game_state_id, input_stream, mark) do
    parsed_move = UI.Utilities.get_next_move(game_state_id, input_stream, mark)
    Game.StateManager.add_move(game_state_id, parsed_move)
  end

  def play({player_one_stream, player_one_mark}, {player_two_stream, player_two_mark}, game_state_id) do
    do_play({player_one_stream, player_one_mark}, {player_two_stream, player_two_mark}, game_state_id)
  end

  def do_play({current_player_stream, current_player_mark}, {next_player_stream, next_player_mark}, state_id) do
    case Game.StateManager.get_board(state_id) |> Board.Evaluation.status() do
      {:win, winner} ->
        IO.puts "The winner was: " <> Atom.to_string(winner)
      :draw ->
        IO.puts "It was a draw!"
      :incomplete ->
        next_move(state_id, current_player_stream, current_player_mark)
        do_play({next_player_stream, next_player_mark}, {current_player_stream, current_player_mark}, state_id)
    end
  end

end
