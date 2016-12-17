defmodule UI.ConsoleInputTest do
  use ExUnit.Case
  import TestHelpers
  import ExUnit.CaptureIO

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
