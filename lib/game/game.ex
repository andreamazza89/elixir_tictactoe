defmodule Game.Engine do
  defstruct board: %Board{}, players: {%Player.Human{mark: :x}, %Player.LinearCpu{mark: :o}}

  defimpl Game, for: Game.Engine do

    def status(game = %Game.Engine{}, board_module \\ Board) do
      board_module.status(game.board)
    end

    def get_current_player(%Game.Engine{players: {current_player, _next_player}}) do
      current_player
    end

    def mark_cell_for_current_player(game = %Game.Engine{players: {current_player, next_player}}, cell_to_mark) do
      updated_board = Board.add_move(game.board, {cell_to_mark, current_player.mark})
      %Game.Engine{board: updated_board, players: {next_player, current_player}}
    end

    def make_next_move(game = %Game.Engine{}) do
      current_player = get_current_player(game)
      cell_to_mark = Player.get_next_move(current_player, game) 
      Game.mark_cell_for_current_player(game, cell_to_mark)
    end

  end
end
