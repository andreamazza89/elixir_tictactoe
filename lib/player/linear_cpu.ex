defmodule Player.LinearCpuPlayer do
  defstruct mark: :x
end

defimpl Player, for: Player.LinearCpuPlayer do

  def get_next_move(_player, game) do
    game.board |> Board.available_moves |> List.first
  end

end
