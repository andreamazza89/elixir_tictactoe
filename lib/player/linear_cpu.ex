defmodule Player.LinearCpu do
  defstruct mark: :x
end

defimpl Player, for: Player.LinearCpu do

  def get_next_move(_player, game) do
    if Application.get_env(:elixir_tictactoe, :cpu_sleep), do: :timer.sleep(1000) 
    game.board |> Board.available_moves |> List.first
  end

end
