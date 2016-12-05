defmodule IntegrationAddMoveTest do
  use ExUnit.Case

  test "adding a move to the board" do
    game_state_id = Game.StateManager.start_game
    move = "A1" |> UI.InputParser.parse_move(:x)
    Game.StateManager.add_move(game_state_id, move)
    updated_board = Game.StateManager.get_board(game_state_id)

    assert updated_board === [:x, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty]
  end
  
end
