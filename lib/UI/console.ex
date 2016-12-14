defmodule UI.Console do

  @visual_board_template "
  1 | 2 | 3 
  ----------
A a | b | c 
  ----------
B d | e | f 
  ----------
C g | h | i "  

  def play(game) do
    case Game.status(game) do
      {:win, winner} ->
        announce_winner(winner)
      :draw ->
        announce_draw
      :incomplete ->
        announce_next_move(game)
        updated_game = Game.make_next_move(game)
        play(updated_game)
    end
  end

  def ask_game_mode(input_device) do
    do_ask_game_mode(input_device, try_again: false)
  end

  defp do_ask_game_mode(input_device, try_again: try_again?) do
    announce_game_mode_selection(try_again: try_again?)
    selected_game_mode = IO.gets(input_device, "\n") |> String.trim

    case selected_game_mode do
      "1" -> :human_v_human
      "2" -> :human_v_linear_machine
      "3" -> :linear_machine_v_linear_machine
      "4" -> :human_v_minimax_machine
      "5" -> :linear_machine_v_minimax_machine
      "6" -> :minimax_machine_v_minimax_machine
       _  -> do_ask_game_mode(input_device, try_again: true)
    end
  end

  def ask_swap_play_order(input_device) do
    announce_swap_order_selection()
    swap? = IO.gets(input_device, "\n") |> String.trim
    Regex.match?(~r{^Y(es)?$}i, swap?)
  end

  def render_board(%Board{cells: [a,b,c,d,e,f,g,h,i]}, mark_to_string) do
    String.replace(@visual_board_template, "a", mark_to_string[a]) 
      |> String.replace("b", mark_to_string[b]) 
      |> String.replace("c", mark_to_string[c]) 
      |> String.replace("d", mark_to_string[d]) 
      |> String.replace("e", mark_to_string[e]) 
      |> String.replace("f", mark_to_string[f]) 
      |> String.replace("g", mark_to_string[g]) 
      |> String.replace("h", mark_to_string[h]) 
      |> String.replace("i", mark_to_string[i]) 
  end

  def announce_winner(winner) do
    winners_mark = winner.mark
    clear_and_print "The winner was: " <> Atom.to_string(winners_mark)
  end

  def announce_draw do
    clear_and_print "It was a draw!"
  end

  def announce_next_move(game) do
    current_player = Game.get_current_player(game)
    clear_and_print "It is " <> Atom.to_string(current_player.mark) <> 
                    "'s turn, please pick a move:" <>
                    render_board(game.board, [empty: " ", x: "x", o: "o"] )
  end

  defp announce_game_mode_selection(try_again: try_again?) do
    clear_and_print (if try_again? do 
                      "Invalid selection, please try again\n"
                     else
                      ""
                     end) <>
                    "Please select a game mode (enter mode number): \n" <>
                    "  1 - human vs human\n" <>
                    "  2 - human vs dumb machine\n" <>
                    "  3 - dumb machine vs dumb machine\n" <>
                    "  4 - human vs clever machine\n" <>
                    "  5 - dumb machine vs clever machine\n" <>
                    "  6 - clever machine vs clever machine\n"
  end

  defp announce_swap_order_selection do
    clear_and_print "Would you like to swap the playing order?"
  end

  defp clear_and_print(message) do
    clear_screen = IO.ANSI.clear()
    send_cursor_to_top = IO.ANSI.home()
    IO.puts clear_screen
    IO.puts send_cursor_to_top
    IO.puts message 
  end

end
