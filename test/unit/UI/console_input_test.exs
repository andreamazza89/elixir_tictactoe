defmodule UI.ConsoleInputTest do
  use ExUnit.Case
  import TestHelpers
  import PromptRegexes
  import ExUnit.CaptureIO

  describe "asking board size for a new game" do

    test "fetches and parses the selected board size (example one)" do
      user_input = create_input_stream("3\n")
      valid_input = [3, 4]

      assert UI.Console.ask_board_size(user_input, valid_input) === 3
    end

    test "fetches and parses the selected board size (example two)" do
      user_input = create_input_stream("4\n")
      valid_input = [3, 4]

      assert UI.Console.ask_board_size(user_input, valid_input) === 4
    end

    test "keeps asking the user if the input is invalid (bad format)" do
      user_input = create_input_stream("a\n3\n")
      valid_input = [3, 4]

      assert UI.Console.ask_board_size(user_input, valid_input) === 3
    end

    test "keeps asking the user if the input is invalid (size unavailable)" do
      user_input = create_input_stream("5\n3\n")
      valid_input = [3, 4]

      assert UI.Console.ask_board_size(user_input, valid_input) === 3
    end

    test "shows the error message when the user enters invalid input" do
      user_input = create_input_stream("5\n3\n")
      valid_input = [3, 4]
      action = fn() -> UI.Console.ask_board_size(user_input, valid_input) end

      assert Regex.match?(~r{Invalid size: please try again. Only 3 or 4 are available}, capture_io(action)) 
    end

    test "clears the screen before prompting the user" do
      user_input = create_input_stream("3\n")
      valid_input = [3, 4]
      action = fn() -> UI.Console.ask_board_size(user_input, valid_input) end

      assert_console_output_matches(clear_screen_regex, action)
    end

    test "promts the user with the appropriate question" do
      user_input = create_input_stream("3\n")
      valid_input = [3, 4]
      action = fn() -> UI.Console.ask_board_size(user_input, valid_input) end

      assert_console_output_matches(ask_board_size_regex, action)
    end

  end


  describe "fetching next move" do

    test "fetches and parses the user's move (example one)" do
      board_size = 3
      player_input = create_input_stream("B1\n")
      valid_input = [3]

      assert UI.Console.ask_next_move(player_input, board_size, valid_input) === 3
    end

    test "fetches and parses the user's move (example two)" do
      board_size = 2
      player_input = create_input_stream("B1\n")
      valid_input = [2]

      assert UI.Console.ask_next_move(player_input, board_size, valid_input) === 2
    end

    test "keeps asking the user for a move until the input is valid (bad format)" do
      board_size = 3
      player_input = create_input_stream("ZZ\nA2\n")
      valid_input = [1]

      assert UI.Console.ask_next_move(player_input, board_size, valid_input) === 1
    end

    test "keeps asking the user for a move until the input is valid (invalid move)" do
      board_size = 3
      player_input = create_input_stream("A1\nA2\n")
      valid_input = [1]

      assert UI.Console.ask_next_move(player_input, board_size, valid_input) === 1
    end

    test "shows the error message for a move when the user enters invalid input" do
      board_size = 3
      player_input = create_input_stream("A1\nA2\n")
      valid_input = [1]
      action = fn() -> UI.Console.ask_next_move(player_input, board_size, valid_input) end

      assert Regex.match?(~r{Invalid move: please try again.}, capture_io(action)) 
    end

  end
end
