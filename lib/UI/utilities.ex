defmodule UI.Utilities do

  def get_next_move(board, input_stream, mark) do
    IO.puts Board.Presentation.render(board, [empty: " ", x: "x", o: "o"] )
    IO.gets(input_stream, "\n") |> String.trim |> UI.InputParser.parse_move(mark)
  end

end
