defmodule Board do
  defstruct cells: [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]

  def add_move(board = %Board{}, {cell_index, players_mark}) do
    old_cells = board.cells
    new_cells = List.replace_at(old_cells, cell_index, players_mark)
    %Board{board | cells: new_cells}
  end

  def available_moves(%Board{cells: cells}) do
    cells |> Enum.with_index |> Enum.reduce([], &add_empty_cell_to_list/2) 
  end

  defp add_empty_cell_to_list({cell_status, cell_index}, available_moves) do
    if (cell_status === :empty) do 
      List.insert_at(available_moves, -1, cell_index) 
    else
      available_moves
    end
  end

  def status(board = %Board{}) do
    cells = board.cells
    rows_cols_diags = get_rows(cells) ++ get_columns(cells) ++ get_diagonals(cells)
    cond do
      any_winning_collection?(rows_cols_diags, :x) -> {:win, :x}
      any_winning_collection?(rows_cols_diags, :o) -> {:win, :o}
      all_cells_have_a_mark?(rows_cols_diags) -> :draw
      true -> :incomplete
    end
  end

  def empty?(board = %Board{}) do
    Enum.all?(board.cells, &(&1 === :empty))
  end

  defp any_winning_collection?(rows_cols_diags, mark) do
    cell_has_mark? = fn(cell) -> cell === mark end
    all_cells_same_mark? = fn(collection) -> Enum.all?(collection, cell_has_mark?) end
    Enum.any?(rows_cols_diags, all_cells_same_mark?)
  end

  defp all_cells_have_a_mark?(rows_cols_diags) do
    Enum.all?(List.flatten(rows_cols_diags), fn(cell) -> cell !== :empty end)
  end

  def get_rows([a,b,c,d,e,f,g,h,i]) do
    [[a,b,c],[d,e,f],[g,h,i]]
  end

  defp get_columns([a,b,c,d,e,f,g,h,i]) do
    [[a,d,g],[b,e,h],[c,f,i]]
  end

  defp get_diagonals([a,_b,c,_d,e,_f,g,_h,i]) do
    [[a,e,i],[g,e,c]]
  end

end
