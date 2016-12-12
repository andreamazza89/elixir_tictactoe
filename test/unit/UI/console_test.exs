defmodule UI.ConsoleTest do
  use ExUnit.Case
  import TestHelpers

  describe "asking the user for game options" do

    test "parses user-selected game mode, human v human" do
      user = create_input_stream("1\n")
      assert UI.Console.ask_game_mode(user, try_again: false) === :human_v_human
    end

    test "parses user-selected game mode, human v linear machine" do
      user = create_input_stream("2\n")
      assert UI.Console.ask_game_mode(user, try_again: false) === :human_v_linear_machine
    end

    test "parses user-selected game mode, linear machine v linear machine" do
      user = create_input_stream("3\n")
      assert UI.Console.ask_game_mode(user, try_again: false) === :linear_machine_v_linear_machine
    end

    test "keeps asking until an available mode is selected" do
      user = create_input_stream("9\n1\n")
      assert UI.Console.ask_game_mode(user, try_again: false) === :human_v_human
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

  end
end
