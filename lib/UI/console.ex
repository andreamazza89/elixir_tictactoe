defmodule UI.Console do

  @capital_a 65

  @visual_board_template_size_three "
  1 | 2 | 3 
  ----------
A a | b | c 
  ----------
B d | e | f 
  ----------
C g | h | i "  

  @visual_board_template_size_four "
  1 | 2 | 3 | 4 
  ------------- 
A a | b | c | d 
  ------------- 
B e | f | g | h 
  ------------- 
C i | j | k | l 
  ------------- 
D m | n | O | p "

  def render_board(%Board{cells: [a,b,c,d,e,f,g,h,i]}, mark_to_string) do
    String.replace(@visual_board_template_size_three, "a", mark_to_string[a]) 
      |> String.replace("b", mark_to_string[b]) 
      |> String.replace("c", mark_to_string[c]) 
      |> String.replace("d", mark_to_string[d]) 
      |> String.replace("e", mark_to_string[e]) 
      |> String.replace("f", mark_to_string[f]) 
      |> String.replace("g", mark_to_string[g]) 
      |> String.replace("h", mark_to_string[h]) 
      |> String.replace("i", mark_to_string[i]) 
  end

  def render_board(%Board{cells: [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p]}, mark_to_string) do
    String.replace(@visual_board_template_size_four, "a", mark_to_string[a]) 
      |> String.replace("b", mark_to_string[b]) 
      |> String.replace("c", mark_to_string[c]) 
      |> String.replace("d", mark_to_string[d]) 
      |> String.replace("e", mark_to_string[e]) 
      |> String.replace("f", mark_to_string[f]) 
      |> String.replace("g", mark_to_string[g]) 
      |> String.replace("h", mark_to_string[h]) 
      |> String.replace("i", mark_to_string[i]) 
      |> String.replace("j", mark_to_string[j]) 
      |> String.replace("k", mark_to_string[k]) 
      |> String.replace("l", mark_to_string[l]) 
      |> String.replace("m", mark_to_string[m]) 
      |> String.replace("n", mark_to_string[n]) 
      |> String.replace("O", mark_to_string[o]) 
      |> String.replace("p", mark_to_string[p]) 
  end

  #def render_board(board = %Board{}, mark_to_string) do
  #  generate_header(board) <> generate_rows(board, mark_to_string)
  #end

  #defp generate_header(board) do
  #  board_size = Board.size(board)
  #  "  " <>   
  #  ((1..board_size) |> Enum.map(&number_to_column_header/1) |> Enum.join())
  #    |> String.replace(~r{\|$}, "\n")
  #end

  #defp number_to_column_header(number) do
  #  " " <> Integer.to_string(number) <> " |"
  #end

  #defp generate_rows(board, mark_to_string) do
  #  board_size = Board.size(board)
  #  (1..board_size) |> Enum.map() |> Enum.join() |> String.trim
  #  "" 
  #end

  #defp number_to_row(number, mark_to_string, board) do
  #  " " <> Integer.to_string(number) <> " |"
  #end

  #defp row_letter (offset_from_A) do
  #   
  #end

  def ask_next_move(input_device, board_size, valid_input) do
    fetch_input = fn() -> 
                    raw_move = ask_for_raw_move(input_device)  
                    parse_cartesian_coordinates(raw_move, board_size) 
                  end 
    error_message = "Invalid move: please try again."
    validate_input(fetch_input, valid_input, error_message)
  end

  defp validate_input(fetch_input, valid_input, error_message) do
    input = fetch_input.()
    if Enum.member?(valid_input, input) do
      input
    else
      IO.puts error_message
      validate_input(fetch_input, valid_input, error_message)
    end
  end

  defp ask_for_raw_move(input_device) do
    IO.gets(input_device, "\n")
  end

  defp parse_cartesian_coordinates(coordinates, board_size) do
    if Regex.match?(~r{[a-zA-Z][0-9]}, coordinates) do
      zero_index_adjusted_column = coordinates |> String.trim |> String.last 
                                     |> String.to_integer |> subtract(1)

      row_character = coordinates |> String.first |> String.to_charlist |> List.first
      row_offset = row_character |> offset_from_capital_a() |> times(board_size) 

      zero_index_adjusted_column + row_offset
    else
      -1
    end
  end

  defp subtract(number, other_number) do
    number - other_number
  end

  defp times(number, other_number) do
    number * other_number
  end

  defp offset_from_capital_a(character) do
    character - @capital_a
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

  def ask_play_again?(input_device) do
    print "Would you like to play again?"
    user_input = IO.gets(input_device, "\n")
    case user_input do
      "y\n" -> true
      "n\n" -> false
    end
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
                    render_board(game.board, %{empty: " ", x: "x", o: "o"} )
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

  defp print(message) do
    IO.puts message
  end

end
