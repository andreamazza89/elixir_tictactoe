defmodule UI.ConsoleTest do
  use ExUnit.Case
  import TestHelpers

  describe "parsing user input" do

    test "converts the user's input into a move (example one)" do
      assert UI.Console.parse_move("A1") === 0
    end

    test "converts the user's input into a move (example two)" do
      assert UI.Console.parse_move("A2") === 1
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
