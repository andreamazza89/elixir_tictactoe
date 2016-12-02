defmodule Board.ManipulationTest do
  use ExUnit.Case

  @empty_board [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]

  describe "adding a move to the board" do

    test "updates the board accordingly(example 1)" do
      assert Board.Manipulation.add_move(@empty_board, {0, :x}) === 
        [:x,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
    end

    test "updates the board accordingly(example 2)" do
      assert Board.Manipulation.add_move(@empty_board, {2, :x}) ===
        [:empty,:empty,:x,:empty,:empty,:empty,:empty,:empty,:empty]
    end
  end
end
