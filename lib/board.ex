defmodule Board do

  def add_move(board, {cell_index, players_mark}) do
    List.replace_at(board, cell_index, players_mark)
  end

end
