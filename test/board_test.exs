defmodule BoardTest do
  use ExUnit.Case

  @empty_board [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]

  describe "adding a move to the board" do
    test "adds a move to the board (example 1)" do
      assert Board.add_move(@empty_board, {0, :x}) === 
        [:x,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
    end

    test "adds a move to the board (example 2)" do
      assert Board.add_move(@empty_board, {2, :x}) ===
        [:empty,:empty,:x,:empty,:empty,:empty,:empty,:empty,:empty]
    end
  end
end
