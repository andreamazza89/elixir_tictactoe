defmodule Board.PresentationTest do
  use ExUnit.Case
  import TestHelpers

  test "renders an empty board into a string" do
    assert Board.Presentation.render(create_board([x: [], o: []]), %{empty: " "}) === "
  1 | 2 | 3 
  ----------
A   |   |   
  ----------
B   |   |   
  ----------
C   |   |   "  
  end

  test "renders a draw board into a string" do
    assert Board.Presentation.render(create_board([x: [2,5,6,7,9], o: [1,3,4,8]]), %{empty: " ", x: "x", o: "o"}) === "
  1 | 2 | 3 
  ----------
A o | x | o 
  ----------
B o | x | x 
  ----------
C x | o | x "
  end

end
