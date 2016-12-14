defmodule Game.RunnerTest do
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

    test "delegates to the UI when the game results in a win, including the winner (one)" do
      draw_board = create_board([x: [1,2,3], o: [4,5]])
      draw_game = %Game{board: draw_board, players: {"player_two", "player_one"}} 
      user_interface = SpyUserInterface

      Game.Runner.game_loop(draw_game, user_interface)
  
      assert_receive :spy_user_interface_received_announce_win_with_player_one
    end

    test "delegates to the UI when the game results in a win, including the winner (two)" do
      draw_board = create_board([x: [1,2], o: [4,5,6]])
      draw_game = %Game{board: draw_board, players: {"player_one", "player_two"}} 
      user_interface = SpyUserInterface

      Game.Runner.game_loop(draw_game, user_interface)
  
      assert_receive :spy_user_interface_received_announce_win_with_player_two
    end

    test "delegates to the UI when the game is incomplete" do
      incomplete_board = create_board([x: [], o: []])
      cpu_one = %Player.LinearCpu{mark: :x}
      cpu_two = %Player.LinearCpu{mark: :o}
      incomplete_game = %Game{board: incomplete_board, players: {cpu_one, cpu_two}}
      user_interface = SpyUserInterface

      Game.Runner.game_loop(incomplete_game, user_interface)

      assert_receive :spy_user_interface_received_announce_next_move_with_game      
    end

  end
end