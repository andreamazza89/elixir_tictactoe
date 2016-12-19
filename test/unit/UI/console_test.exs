defmodule UI.ConsoleTest do
  use ExUnit.Case
  import TestHelpers
  import PromptRegexes

  describe "asking the user for game options" do

    test "parses user-selected game mode, human v human" do
      user = create_input_stream("1\n")
      assert UI.Console.ask_game_mode(user) === :human_v_human
    end

    test "parses user-selected game mode, human v linear machine" do
      user = create_input_stream("2\n")
      assert UI.Console.ask_game_mode(user) === :human_v_linear_machine
    end

    test "parses user-selected game mode, linear machine v linear machine" do
      user = create_input_stream("3\n")
      assert UI.Console.ask_game_mode(user) === :linear_machine_v_linear_machine
    end

    test "keeps asking until an available mode is selected" do
      user = create_input_stream("9\ns\n!\n1\n")
      assert UI.Console.ask_game_mode(user) === :human_v_human
    end

    test "parses user-selected swap choice, user wants swap (y)" do
      user = create_input_stream("y\n")
      assert UI.Console.ask_swap_play_order(user) === true 
    end

    test "parses user-selected swap choice, user wants swap (Y)" do
      user = create_input_stream("Y\n")
      assert UI.Console.ask_swap_play_order(user) === true 
    end

    test "parses user-selected swap choice, user wants swap (Yes)" do
      user = create_input_stream("Yes\n")
      assert UI.Console.ask_swap_play_order(user) === true 
    end

    test "parses user-selected swap choice, user wants swap (yes)" do
      user = create_input_stream("yes\n")
      assert UI.Console.ask_swap_play_order(user) === true 
    end

    test "parses user-selected swap choice, user does not want to swap (no)" do
      user = create_input_stream("no\n")
      assert UI.Console.ask_swap_play_order(user) === false 
    end

  end


  describe "prompts" do

    test "prompts the current player for a move, showing the board" do 
      empty_board = create_board([x: [], o: []])
      player_one = %Player.Human{mark: :x}
      player_two = "player_two"
      game = %Game{board: empty_board, players: {player_one, player_two}}      
      action = fn() -> UI.Console.announce_next_move(game) end
  
      assert_console_output_matches(clear_screen_regex, action)
      assert_console_output_matches(next_move_prompt_regex, action)
      assert_console_output_matches(empty_board_regex(game), action)
    end

    test "prompts the current player to play again" do
      input_stream = create_input_stream("y\nn\n")
      action = fn() -> UI.Console.ask_play_again?(input_stream) end
      
      assert_console_output_matches(play_again_regex, action)
    end

    test "returns the parsed user choice (play again? yes!)" do
      input_stream = create_input_stream("y\n")
  
      assert UI.Console.ask_play_again?(input_stream) === true
    end

    test "returns the parsed user choice (play again? no!)" do
      input_stream = create_input_stream("n\n")
  
      assert UI.Console.ask_play_again?(input_stream) === false
    end

    test "announces the winner" do
      winner = %Player.Human{mark: :x}
      action = fn() -> UI.Console.announce_winner(winner) end

      assert_console_output_matches(clear_screen_regex, action)
      assert_console_output_matches(announce_winner_regex(winner), action)
    end

    test "announces a draw" do
      action = fn() -> UI.Console.announce_draw end

      assert_console_output_matches(clear_screen_regex, action)
      assert_console_output_matches(announce_draw_regex, action)
    end

  end


  describe "rendering a board into a visual representation" do

    test "renders an empty board into a string" do
      empty_board = create_board([x: [], o: []])
      visual_marks_representation = %{empty: " "}
      assert UI.Console.render_board(empty_board, visual_marks_representation) === "
  1 | 2 | 3 
  ----------
A   |   |   
  ----------
B   |   |   
  ----------
C   |   |   "  
    end

    test "renders a draw board into a string" do
      draw_board = create_board([x: [2,5,6,7,9], o: [1,3,4,8]])
      visual_marks_representation = %{empty: " ", x: "x", o: "o"}
      assert UI.Console.render_board(draw_board, visual_marks_representation) === "
  1 | 2 | 3 
  ----------
A o | x | o 
  ----------
B o | x | x 
  ----------
C x | o | x "
    end

    test "renders a four-sized board into a string" do
      draw_board = create_board([size: 4, x: [1,2,3,4,5,6,7,8], o: [9,10,11,12,13,14,15,16]])
      visual_marks_representation = %{empty: " ", x: "x", o: "o"}
      assert UI.Console.render_board(draw_board, visual_marks_representation) === "
  1 | 2 | 3 | 4 
  ------------- 
A x | x | x | x 
  ------------- 
B x | x | x | x 
  ------------- 
C o | o | o | o 
  ------------- 
D o | o | o | o "
    end

  end
end
