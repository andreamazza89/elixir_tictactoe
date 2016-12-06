defmodule IntegrationAddMoveTest do
  use ExUnit.Case
  import TestHelpers

  test "adding a move to the board" do
    game_state_id = Game.StateManager.start_game
    input_stream = create_input_stream("A1\n")

    Game.Engine.play_next_move(game_state_id, input_stream, :x)

    assert get_cell_at(0, game_state_id) === :x
  end
  
end
