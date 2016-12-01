defmodule BoardTest do
  use ExUnit.Case

  @empty_board [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
  @no_winner_no_draw [:x,:empty,:o,:empty,:x,:empty,:empty,:empty,:empty]
  @crosses_wins [:x,:x,:x,:o,:o,:empty,:empty,:empty,:empty]

  describe "adding a move to the board" do
    test "updates the board accordingly(example 1)" do
      assert Board.add_move(@empty_board, {0, :x}) === 
        [:x,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
    end

    test "updates the board accordingly(example 2)" do
      assert Board.add_move(@empty_board, {2, :x}) ===
        [:empty,:empty,:x,:empty,:empty,:empty,:empty,:empty,:empty]
    end
  end


  describe "checking the board status" do
    test "an empty board is incomplete" do
      assert Board.status(@empty_board) === :incomplete
    end

    test "a board with no winner nor draw is incomplete" do
      assert Board.status(@no_winner_no_draw) === :incomplete
    end

    test "a board with a winner is recognised" do
      assert Board.status(@crosses_wins) === {:win, :x}
    end
  end
end
