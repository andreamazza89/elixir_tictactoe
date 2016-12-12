defmodule PlayGame do

  def main(_) do
    game_mode = UI.Console.ask_game_mode(:stdio, try_again: false)
    swap? = UI.Console.ask_swap_play_order(:stdio)
    game = Menu.create_game([mode: game_mode, swap_order: swap?])

    UI.Console.play(game)
  end

end
