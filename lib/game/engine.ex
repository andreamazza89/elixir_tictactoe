defmodule Game.Engine do

  #hello side effects!
  def next_move(game_state_id, input_stream) do
    raw_move = IO.gets(input_stream, "\n") |> String.trim
    parsed_move = raw_move |> UI.InputParser.parse_move(:x)
    
    Game.StateManager.add_move(game_state_id, parsed_move)
  end

end
