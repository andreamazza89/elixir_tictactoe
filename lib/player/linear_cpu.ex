defmodule Player.LinearCpu do
  defstruct mark: :x
end

defimpl Player, for: Player.LinearCpu do

  def get_next_move(_player, game) do
    game.board |> Board.available_moves |> List.first
  end

end
