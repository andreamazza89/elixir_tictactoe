ExUnit.start()

defmodule TestHelpers do

  def get_cell_at(index, game_state_id) do
    board = Game.StateManager.get_board(game_state_id)
    Enum.at(board, index)
  end

  def create_input_stream(lines) do
    {:ok, input_stream} = StringIO.open(lines) 
    input_stream
  end

end
