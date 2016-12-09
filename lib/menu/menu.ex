defmodule Menu do

  def create_game([mode: mode, swap_order: swap?]) do

    game = 
      case mode do
        :human_v_human -> 
          %Game{players: {%Player.Human{mark: :x}, %Player.Human{mark: :o}}}
        :human_v_linear_machine -> 
          %Game{players: {%Player.Human{mark: :x}, %Player.LinearCpu{mark: :o}}}
        :linear_machine_v_linear_machine -> 
          %Game{players: {%Player.LinearCpu{mark: :x}, %Player.LinearCpu{mark: :o}}}
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
