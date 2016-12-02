defmodule Board.EvaluationTest do
  use ExUnit.Case

  @empty_board [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
  @no_winner_no_draw [:x,:empty,:o,:empty,:x,:empty,:empty,:empty,:empty]
  @crosses_wins_row [:x,:x,:x,:o,:o,:empty,:empty,:empty,:empty]
  @crosses_wins_column [:x,:empty,:o,:x,:o,:empty,:x,:empty,:empty]
  @naughts_wins [:o,:o,:o,:x,:x,:empty,:empty,:empty,:empty]
  @draw [:x,:o,:x,:x,:o,:o,:o,:x,:x]

  describe "checking the board status" do

    test "an empty board is incomplete" do
      assert Board.Evaluation.status(@empty_board) === :incomplete
    end

    test "a board with no winner nor draw is incomplete" do
      assert Board.Evaluation.status(@no_winner_no_draw) === :incomplete
    end

    test "a board with a winner is recognised (crosses wins EXAMPLE 1)" do
      assert Board.Evaluation.status(@crosses_wins_row) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins EXAMPLE 2)" do
      assert Board.Evaluation.status(@crosses_wins_column) === {:win, :x}
    end

    test "a board with a winner is recognised (naughts wins)" do
      assert Board.Evaluation.status(@naughts_wins) === {:win, :o}
    end

    test "a draw board is recognised" do
      assert Board.Evaluation.status(@draw) === :draw
    end
  end
end
