defmodule Player.Human do
  defstruct io: {UI.Console, :stdio}, mark: :x
end

defimpl Player, for: Player.Human do

  def get_next_move(player, game) do
    {user_interface, input_device} = player.io
    board_size = Board.size(game.board)
    valid_moves = Board.available_moves(game.board)
    user_interface.ask_next_move(input_device, board_size, valid_moves)
  end

end
