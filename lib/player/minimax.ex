defmodule Player.MiniMax do
  defstruct mark: :x

  defimpl Player, for: Player.MiniMax do

    def get_next_move(player, game) do
      available_moves = Board.available_moves(game.board)
      rank_move_outcome_for_this_game = rank_move_outcome(game, player.mark, 0)
      Enum.max_by(available_moves, rank_move_outcome_for_this_game) 
    end

    defp rank_move_outcome(game, maximising_players_mark, depth) do
      fn(move) -> 
        next_game_state = Game.mark_cell_for_current_player(game, move) 
        if game_over?(next_game_state) do
          rate_game_outcome(next_game_state, maximising_players_mark, depth)
        else
          rate_intermediate_board_value(next_game_state, maximising_players_mark, depth)
        end
      end
    end

    defp game_over?(game) do
      Game.status(game) !== :incomplete 
    end

    defp rate_game_outcome(game, maximising_players_mark, depth) do
      case Game.status(game) do
        {:win, maximising_players_mark} -> 10 - depth 
        {:win, _} -> depth - 10
        :draw -> 0
      end
    end

    defp rate_intermediate_board_value(game, maximising_players_mark, depth) do
      current_player = Game.get_current_player(game)
      available_moves = Board.available_moves(game.board)
      rank_move_outcome_for_this_game = rank_move_outcome(game, maximising_players_mark, depth + 1)
      if current_player.mark === maximising_players_mark do
        Enum.max_by(available_moves, rank_move_outcome_for_this_game) 
      else
        Enum.min_by(available_moves, rank_move_outcome_for_this_game) 
      end
    end

  end
end
