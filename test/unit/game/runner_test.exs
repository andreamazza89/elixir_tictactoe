defmodule RunnerTest do
  use ExUnit.Case, async: true
  import TestHelpers

  describe "game loop" do

    test "delegates to the UI when the game results in a draw" do
      draw_board = create_board([x: [1,2,6,7,9], o: [3,4,5,8]])
      draw_game = %Game{board: draw_board} 
      user_interface = SpyUserInterface
      Game.Runner.game_loop(draw_game, user_interface)
  
      assert_receive :spy_user_interface_received_announce_draw
    end

    test "delegates to the UI when the game results in a win, passing the winner" do
      draw_board = create_board([x: [1,2,3], o: [4,5]])
      draw_game = %Game{board: draw_board, players: {%Player.Human{mark: :x}, %Player.Human{mark: :o}}} 
      user_interface = SpyUserInterface
      Game.Runner.game_loop(draw_game, user_interface)
  
      assert_receive :spy_user_interface_received_announce_win_with_player_one
    end

  end
end
