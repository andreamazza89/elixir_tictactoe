defmodule UI.Utilities do

  def get_next_move(game_state_id, input_stream, mark) do
    IO.puts Board.Presentation.render(Game.StateManager.get_board(game_state_id), [empty: " ", x: "x", o: "o"] )
    IO.gets(input_stream, "\n") |> String.trim |> UI.InputParser.parse_move(mark)
  end

end
