defmodule Board do

  def add_move(board, {cell_index, players_mark}) do
    List.replace_at(board, cell_index, players_mark)
  end

  def status(board) do
    rows_cols_diags = get_rows(board) ++ get_columns(board) ++ get_diagonals(board)
    report(rows_cols_diags)
  end

  defp get_rows([a,b,c,d,e,f,g,h,i]) do
    [[a,b,c],[d,e,f],[g,h,i]]
  end

  defp get_columns([a,b,c,d,e,f,g,h,i]) do
    [[a,d,g],[b,e,h],[c,f,i]]
  end

  defp get_diagonals([a,b,c,d,e,f,g,h,i]) do
    [[a,e,i],[g,e,c]]
  end

  defp report(rows_cols_diags) do
    cond do
      Enum.any?(rows_cols_diags, fn(collection) -> Enum.all?(collection, fn(cell) -> cell === :x end) end) -> {:win, :x}
      Enum.any?(rows_cols_diags, fn(collection) -> Enum.all?(collection, fn(cell) -> cell === :o end) end) -> {:win, :o}
      Enum.all?(List.flatten(rows_cols_diags), fn(cell) -> cell !== :empty end) -> :draw
      true -> :incomplete
    end
  end

end
