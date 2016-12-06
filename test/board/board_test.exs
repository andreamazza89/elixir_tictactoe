defmodule BoardTest do
  use ExUnit.Case
  import TestHelpers

  describe "checking the board status" do

    test "an empty board is incomplete" do
      assert Board.status(create_board([x: [], o: []])) === :incomplete
    end

    test "a board with no winner nor draw is incomplete" do
      assert Board.status(create_board([x: [1,5], o: [3]])) === :incomplete
    end

    test "a board with a winner is recognised (crosses wins row example)" do
      assert Board.status(create_board([x: [1,2,3], o: [4,5]])) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins column example)" do
      assert Board.status(create_board([x: [1,4,7], o: [3,5]])) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins diagonal example)" do
      assert Board.status(create_board([x: [1,5,9], o: [3,4]])) === {:win, :x}
    end

    test "a board with a winner is recognised (noughts wins)" do
      assert Board.status(create_board([x: [4,5], o: [1,2,3]])) === {:win, :o}
    end

    test "a draw board is recognised" do
      assert Board.status(create_board([x: [2,5,6,7,9], o: [1,3,4,8]])) === :draw
    end

  end


  describe "adding a move to the board" do

    test "updates the board accordingly(example 1)" do
      empty_board = create_board([x: [], o: []])
      expected_board = create_board([x: [1], o: []])
      assert Board.add_move(empty_board, {0, :x}) ===  expected_board
    end

    test "updates the board accordingly(example 2)" do
      empty_board = create_board([x: [], o: []])
      expected_board = create_board([x: [3], o: []])
      assert Board.add_move(empty_board, {2, :x}) === expected_board
    end
  end

end
