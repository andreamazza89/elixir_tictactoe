ExUnit.start()

defmodule TestHelpers do

  def get_cell_at(index, game_state_id) do
    %Board{cells: cells} = Game.StateManager.get_board(game_state_id)
    Enum.at(cells, index)
  end

  def create_human_player_with_moves([moves: moves, mark: mark]) do
    moves_stream = create_input_stream(moves)
    %Player.Human{stream: moves_stream, mark: mark}
  end

  def create_input_stream(lines) do
    {:ok, input_stream} = StringIO.open(lines) 
    input_stream
  end

  def create_board([x: cross_locations, o: noughts_locations]) do
    subtract_one_from_all_elements = fn(list) -> Enum.map(list, &(&1 - 1)) end
    cross_locations = subtract_one_from_all_elements.(cross_locations)
    noughts_locations = subtract_one_from_all_elements.(noughts_locations)
    cells = [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]  
              |> update_multiple_nodes(cross_locations, :x) 
              |> update_multiple_nodes(noughts_locations, :o)
    %Board{cells: cells}
  end

  defp update_multiple_nodes(list, [first_udpate_index | other_indexes], value) do
    updated_list = List.update_at(list, first_udpate_index, fn(_) -> value end)
    update_multiple_nodes(updated_list, other_indexes, value)
  end

  defp update_multiple_nodes(list, [], _) do
    list
  end

end


defmodule SpyBoard do

  def status(_) do
    send self, :spy_board_received_status_call
  end

end
