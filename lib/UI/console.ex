defmodule UI.Console do

  @capital_a 65
  @line_ends_with_pipe_regex ~r{\|$}

  def render_board(board = %Board{}, mark_to_string) do
    generate_header(board) <> generate_rows(board, mark_to_string)
  end

  defp generate_header(board) do
    board_width = Board.width(board)
    "\n " <>   
    ((1..board_width) |> Enum.map(&number_to_column_header/1) |> Enum.join())
      |> String.replace(@line_ends_with_pipe_regex, "\n")
  end

  defp generate_rows(board, mark_to_string) do
    board_width = Board.width(board)
    (0..(board_width - 1)) 
      |> Enum.map(fn(row_number) -> row_number_to_string_row(row_number, mark_to_string, board) end) 
      |> Enum.join() 
      |> String.slice(0..-2)
  end

  defp number_to_column_header(number) do
    " " <> Integer.to_string(number) <> " |"
  end

  defp row_number_to_string_row(row_number, mark_to_string, board) do
    board_width = Board.width(board)
    row_spacer(board_width) <> 
    row_letter(row_number) <> 
    render_row_cells(row_number, mark_to_string, board)
  end

  defp row_spacer(board_width) do
    "  ---" <> String.duplicate("----", board_width - 2) <> "---\n"
  end

  defp row_letter (offset_from_A) do
    <<(@capital_a + offset_from_A)>>
  end
  
  defp render_row_cells(row, mark_to_string, board) do
    board_width = Board.width(board)
    ((0..(board_width - 1)) 
      |> Enum.map(fn(column) -> render_cell(row, column, board, mark_to_string) end)
      |> Enum.join()) |> String.replace(@line_ends_with_pipe_regex, "\n")
      
  end

  defp render_cell(row, column, board, mark_to_string) do
    cell_id = (Board.width(board) * row) + column 
    cell_mark = Enum.at(board.cells, cell_id) 
    " " <> mark_to_string[cell_mark] <> " |"
  end

  def ask_next_move(input_device, board_width, valid_input) do
    fetch_input = fn() -> 
                    raw_move = ask_for_raw_move(input_device)  
                    parse_cartesian_coordinates(raw_move, board_width) 
                  end 
    error_message = "Invalid move: please try again."
    validate_input(fetch_input, valid_input, error_message)
  end

  def ask_board_size(input_device, valid_input) do
    announce_board_size_selection()
    fetch_input = fn() -> 
                    IO.gets(input_device, "\n") |> String.trim() |> string_to_integer_or_nil()
                  end 
    error_message = "Invalid size: please try again. Only 3 or 4 are available"
    validate_input(fetch_input, valid_input, error_message)
  end

  defp announce_board_size_selection do
    clear_and_print("What size board would you like to play with?")
  end

  defp string_to_integer_or_nil(string) do
    if Regex.match?(~r{^\d+$}, string) do
      String.to_integer(string)
    else
      nil
    end
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

  defp parse_cartesian_coordinates(coordinates, board_width) do
    if Regex.match?(~r{[a-zA-Z][0-9]}, coordinates) do
      zero_index_adjusted_column = coordinates |> String.trim |> String.last 
                                     |> String.to_integer |> subtract(1)

      row_character = coordinates |> String.first |> String.to_charlist |> List.first
      row_offset = row_character |> offset_from_capital_a() |> times(board_width) 

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

  def ask_game_mode(input_device, valid_input) do
    announce_game_mode_selection()
    fetch_input = fn() -> 
                    IO.gets(input_device, "\n") |> String.trim() |> game_mode_map()
                  end 
    error_message = "Invalid mode: please try again. Only 1-6 are available"
    validate_input(fetch_input, valid_input, error_message)
  end

  defp announce_game_mode_selection do
    clear_and_print "Please select a game mode (enter mode number): \n" <>
                    "  1 - human vs human\n" <>
                    "  2 - human vs dumb machine\n" <>
                    "  3 - dumb machine vs dumb machine\n" <>
                    "  4 - human vs clever machine\n" <>
                    "  5 - dumb machine vs clever machine\n" <>
                    "  6 - clever machine vs clever machine\n"
  end

  defp game_mode_map(selection) do
    case selection do
      "1" -> :human_v_human
      "2" -> :human_v_linear_machine
      "3" -> :linear_machine_v_linear_machine
      "4" -> :human_v_minimax_machine
      "5" -> :linear_machine_v_minimax_machine
      "6" -> :minimax_machine_v_minimax_machine
       _  -> :invalid_game_mode
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
