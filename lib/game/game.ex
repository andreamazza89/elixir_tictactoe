defmodule Game do
  defstruct board: %Board{}, players: {%Player.Human{mark: :x}, %Player.Human{mark: :o}}

  def status(game = %Game{}, board_module \\ Board) do
    board_module.status(game.board)
  end

  def get_current_player(game = %Game{players: {current_player, _next_player}}) do
    current_player
  end

  def mark_cell_for_current_player(game = %Game{players: {current_player, next_player}}, cell_to_mark) do
    updated_board = Board.add_move(game.board, {cell_to_mark, current_player.mark})
    %Game{board: updated_board, players: {next_player, current_player}}
  end

end
