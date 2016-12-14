defmodule Game.Runner do

  def game_loop(game, user_interface) do
    case Game.status(game) do
      :draw -> 
        user_interface.announce_draw
      {:win, winner} -> 
        user_interface.announce_winner(winner)
      :incomplete ->
        user_interface.announce_next_move(game)
        updated_game = Game.make_next_move(game)
        game_loop(updated_game, user_interface)
    end
  end

end
