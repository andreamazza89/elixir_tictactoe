defmodule Board.EvaluationTest do
  use ExUnit.Case
  import TestHelpers

  describe "checking the board status" do

    test "an empty board is incomplete" do
      assert Board.Evaluation.status(empty_board) === :incomplete
    end

    test "a board with no winner nor draw is incomplete" do
      assert Board.Evaluation.status(no_winner_no_draw) === :incomplete
    end

    test "a board with a winner is recognised (crosses wins EXAMPLE 1)" do
      assert Board.Evaluation.status(crosses_wins_row) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins EXAMPLE 2)" do
      assert Board.Evaluation.status(crosses_wins_column) === {:win, :x}
    end

    test "a board with a winner is recognised (naughts wins)" do
      assert Board.Evaluation.status(noughts_wins) === {:win, :o}
    end

    test "a draw board is recognised" do
      assert Board.Evaluation.status(draw) === :draw
    end

  end
end
