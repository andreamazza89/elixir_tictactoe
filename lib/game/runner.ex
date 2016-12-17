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

  def setup_game(user_interface, input_device) do
    mode = user_interface.ask_game_mode(input_device) 
    swap_order? = user_interface.ask_swap_play_order(input_device) 
    GameFactory.create_game([mode: mode, swap_order: swap_order?])
  end

  def play(io: {user_interface, input_device}) do
    #game = setup_game(user_interface, input_device)
    game = 3
    game_loop(game)
    play_again_or_exit(game, user_interface, input_device)
  end

  defp play_again_or_exit(game, user_interface, input_device) do
    if UI.Console.ask_play_again?(input_device) do
      play(io: {user_interface, input_device})
    else
      exit :game_over
    end
  end

end
