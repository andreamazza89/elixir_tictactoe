defmodule PlayGame do

  def main(_) do
    game_mode = UI.Console.ask_game_mode(:stdio)
    swap? = UI.Console.ask_swap_play_order(:stdio)
    game = GameFactory.create_game([mode: game_mode, swap_order: swap?])
    
    Game.Runner.game_loop(game, UI.Console)
  end

end
