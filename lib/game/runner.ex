defmodule Game.Runner do

  @available_board_sizes [3,4]
  @available_game_modes [:human_v_human, 
                         :human_v_linear_machine,
                         :linear_machine_v_linear_machine,
                         :human_v_minimax_machine,
                         :linear_machine_v_minimax_machine,
                         :minimax_machine_v_minimax_machine
                        ]

  def play(io: {user_interface, input_device}) do
    game = setup_game(user_interface, input_device)
    game_loop(game)
    play_again_or_exit(user_interface, input_device)
  end

  def setup_game(user_interface, input_device) do
    mode = user_interface.ask_game_mode(input_device, @available_game_modes) 
    board_size = user_interface.ask_board_size(input_device, @available_board_sizes) 
    swap_order? = user_interface.ask_swap_play_order(input_device) 
    GameFactory.create_game([board_size: board_size, mode: mode, swap_order: swap_order?], {user_interface, input_device})
  end

  def game_loop(game, user_interface \\ UI.Console) do
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

  defp play_again_or_exit(user_interface, input_device) do
    if UI.Console.ask_play_again?(input_device) do
      play(io: {user_interface, input_device})
    else
      exit :game_over
    end
  end

end
