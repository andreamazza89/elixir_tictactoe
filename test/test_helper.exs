ExUnit.start()

defmodule TestHelpers do

  def get_cell_at(index, game_state_id) do
    %Board{cells: cells} = Game.StateManager.get_board(game_state_id)
    Enum.at(cells, index)
  end

  def create_input_stream(lines) do
    {:ok, input_stream} = StringIO.open(lines) 
    input_stream
  end

  def create_board([x: cross_locations, o: noughts_locations]) do
    cross_locations = cross_locations |> Enum.map(&(&1 - 1))
    noughts_locations = noughts_locations |> Enum.map(&(&1 - 1))
    cells = [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]  
              |> multiple_update(cross_locations, :x) 
              |> multiple_update(noughts_locations, :o)
    %Board{cells: cells}
  end

  defp multiple_update(list, [first_udpate_index | other_indexes], value) do
    updated_list = List.update_at(list, first_udpate_index, fn(_) -> value end)
    multiple_update(updated_list, other_indexes, value)
  end

  defp multiple_update(list, [], _) do
    list
  end

end

