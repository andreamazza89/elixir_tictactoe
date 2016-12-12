defmodule UI.ConsoleTest do
  use ExUnit.Case
  import TestHelpers
  import ExUnit.CaptureIO

  describe "playing the game" do

    test "announces the winner if there is one (crosses wins)" do
      play = fn() -> UI.Console.play(%StubGameReturnsCrossesWinner{}) end

      assert Regex.match?(~r{The winner was: x}, capture_io(play))
    end

    test "announces the winner if there is one (noughts wins)" do
      play = fn() -> UI.Console.play(%StubGameReturnsNoughtsWinner{}) end

      assert Regex.match?(~r{The winner was: o}, capture_io(play))
    end

    test "announces a draw" do
      play = fn() -> UI.Console.play(%StubGameReturnsDraw{}) end

      assert Regex.match?(~r{It was a draw!}, capture_io(play))
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
