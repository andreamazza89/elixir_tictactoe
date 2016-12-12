defmodule MiniMaxTest do
  use ExUnit.Case

  test "runs" do
    player_one = %Player.MiniMax{mark: :x}
    game = %Game{players: {player_one, %Player.MiniMax{mark: :o}}}

    new_game = Player.get_next_move(player_one, game)
  end

end
