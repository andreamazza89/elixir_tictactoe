defmodule Player.MiniMax do
  defstruct mark: :x

  defimpl Player, for: Player.MiniMax do

    def get_next_move(player, game) do
      available_moves = Board.available_moves(game.board)
      if length(available_moves) === 9 do
        0
      else
        rank_move_outcome_for_this_game = rank_move_outcome(game, player.mark, 0)
        Enum.max_by(available_moves, rank_move_outcome_for_this_game) 
      end
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
        {:win, players_mark} -> 
          if players_mark === maximising_players_mark do
            10 - depth 
          else
            depth - 10
          end
        :draw -> 0
      end
    end

    defp rate_intermediate_board_value(game, maximising_players_mark, depth) do
      available_moves = Board.available_moves(game.board)
      rank_move_outcome_for_this_game = rank_move_outcome(game, maximising_players_mark, depth + 1)

      if is_current_player_maximising?(game, maximising_players_mark) do
        Enum.max_by(available_moves, rank_move_outcome_for_this_game) 
      else
        Enum.min_by(available_moves, rank_move_outcome_for_this_game) 
      end

    end

    defp is_current_player_maximising?(game, maximising_players_mark) do
      current_player = Game.get_current_player(game)
      current_player.mark === maximising_players_mark
    end

  end
end
