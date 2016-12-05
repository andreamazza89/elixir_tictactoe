defmodule Game.StateManagerTest do
  use ExUnit.Case

  test "starts a process to store state" do
    game_state = Game.StateManager.start_game()

    assert is_pid(game_state)
  end

  test "retrieves the latest state" do
    game_state = Game.StateManager.start_game()
    
    assert Game.StateManager.get_board(game_state) === [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
  end

  test "updates the state with a move" do
    game_state = Game.StateManager.start_game()
    Game.StateManager.add_move(game_state, {0, :x})
  
    assert Game.StateManager.get_board(game_state) === [:x,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
  end

end
