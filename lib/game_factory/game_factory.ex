defmodule GameFactory do

  def create_game([mode: mode, swap_order: swap?], io \\ {UI.Console, :stdio}) do

    game = 
      case mode do
        :human_v_human -> 
          %Game{players: {%Player.Human{mark: :x, io: io}, %Player.Human{mark: :o, io: io}}}
        :human_v_linear_machine -> 
          %Game{players: {%Player.Human{mark: :x, io: io}, %Player.LinearCpu{mark: :o}}}
        :human_v_minimax_machine -> 
          %Game{players: {%Player.Human{mark: :x, io: io}, %Player.MiniMax{mark: :o}}}
        :linear_machine_v_linear_machine -> 
          %Game{players: {%Player.LinearCpu{mark: :x}, %Player.LinearCpu{mark: :o}}}
        :linear_machine_v_minimax_machine -> 
          %Game{players: {%Player.LinearCpu{mark: :x}, %Player.MiniMax{mark: :o}}}
        :minimax_machine_v_minimax_machine -> 
          %Game{players: {%Player.MiniMax{mark: :x}, %Player.MiniMax{mark: :o}}}
      end

    if swap? do
      swap_players(game)
    else
      game
    end

  end

  defp swap_players(%Game{players: {player_one, player_two}}) do
    %Game{players: {player_two, player_one}}
  end

end
