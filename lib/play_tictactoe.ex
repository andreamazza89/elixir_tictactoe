defmodule PlayGame do

  def main(_) do
    #game_mode = UI.Console.ask_game_mode(:stdio)
    #swap? = UI.Console.ask_swap_play_order(:stdio)
    #game = Menu.create_game([mode: game_mode, swap_order: swap?])
    
    
    game = %Game{players: {%Player.Human{mark: :x}, %Player.MiniMax{mark: :o}}}

    UI.Console.play(game)
  end

end
