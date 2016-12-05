defmodule Game.StateManager do
  
  def start_game do
    {:ok, state_id} = Agent.start_link(fn -> [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty] end)
    state_id
  end

  def get_board(state_id) do
    Agent.get(state_id, &(&1)) 
  end

  def add_move(state_id, move) do
    Agent.update(state_id, fn(current_state) -> Board.Manipulation.add_move(current_state, move) end)
  end

end
