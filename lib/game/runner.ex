defmodule Game.Runner do

  def game_loop(game, user_interface) do
    case Game.status(game) do
      :draw -> user_interface.announce_draw
      {:win, winner} -> user_interface.announce_winner(winner)
    end
  end

 

end
