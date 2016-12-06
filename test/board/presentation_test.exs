defmodule Board.PresentationTest do
  use ExUnit.Case
  import TestHelpers

  test "renders an empty board into a string" do
    assert Board.Presentation.render(empty_board, %{empty: " "}) === "
  1 | 2 | 3 
  ----------
A   |   |   
  ----------
B   |   |   
  ----------
C   |   |   "  
  end

  test "renders a draw board into a string" do
    assert Board.Presentation.render(draw, %{empty: " ", x: "x", o: "o"}) === "
  1 | 2 | 3 
  ----------
A x | o | x 
  ----------
B x | o | o 
  ----------
C o | x | x "
  end

end
