defmodule Game.Runner do

  def game_loop(game, user_interface \\ UI.Console, input_device \\ :stdio) do
    case Game.status(game) do
      :draw -> 
        user_interface.announce_draw
      {:win, winner} -> 
        user_interface.announce_winner(winner)
      :incomplete ->
        user_interface.announce_next_move(game)
        updated_game = Game.make_next_move(game)
        game_loop(updated_game)
    end
  end

  def play(game, input_device) do
    game_loop(game)
    play_again_or_exit(game, input_device)
  end

  defp play_again_or_exit(game, input_device) do
    if UI.Console.ask_play_again?(input_device) do
      play(game, input_device)
    else
      exit :game_over
    end
  end

end
