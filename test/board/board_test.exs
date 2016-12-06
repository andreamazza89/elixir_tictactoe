defmodule BoardTest do
  use ExUnit.Case
  import TestHelpers

  describe "checking the board status" do

    test "an empty board is incomplete" do
      assert Board.status(empty_board) === :incomplete
    end

    test "a board with no winner nor draw is incomplete" do
      assert Board.status(no_winner_no_draw) === :incomplete
    end

    test "a board with a winner is recognised (crosses wins row example)" do
      assert Board.status(crosses_wins_row) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins column example)" do
      assert Board.status(crosses_wins_column) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins diagonal example)" do
      assert Board.status(crosses_wins_diagonal) === {:win, :x}
    end

    test "a board with a winner is recognised (noughts wins)" do
      assert Board.status(noughts_wins) === {:win, :o}
    end

    test "a draw board is recognised" do
      assert Board.status(draw) === :draw
    end

  end


  describe "adding a move to the board" do

    test "updates the board accordingly(example 1)" do
      assert Board.add_move(empty_board, {0, :x}) === 
        [:x,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
    end

    test "updates the board accordingly(example 2)" do
      assert Board.add_move(empty_board, {2, :x}) ===
        [:empty,:empty,:x,:empty,:empty,:empty,:empty,:empty,:empty]
    end
  end

end
