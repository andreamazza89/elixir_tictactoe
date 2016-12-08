defmodule GameTest do
  use ExUnit.Case
  import TestHelpers

  describe "default" do

    test "game defaults to human v machine players" do
      game = %Game{}
      {%Player.Human{}, %Player.LinearCpu{}}  = game.players
    end

  end


  describe "retrieving board status" do

    test "delegates to Board.status to find out the status of the game" do
      game = %Game{}
    
      Game.status(game, SpyBoard)

      assert_receive :spy_board_received_status_call
    end

  end


  describe "adding moves to the board" do
    
    test "adds the player's move to the board" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      game = %Game{players: {player_one, player_two}}
      game_after_one_move = Game.mark_cell_for_current_player(game, 0)
      expected_board_after_one_move = create_board([x: [1], o: []])
      
      assert game_after_one_move.board === expected_board_after_one_move 
    end

  end

  
  describe "getting input from players" do

    test "updates the game with the current player's move" do
      stub_player =  %StubPlayerReturnsCellZero{mark: :x}
      double_player = "double_player"
      game = %Game{players: {stub_player, double_player}}

      updated_game = Game.make_next_move(game)

      assert get_cell_at(0, updated_game) === :x
    end

  end


  describe "turn management" do
    
    test "it is player one's turn at the beginning of the game" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      current_player = %Game{players: {player_one, player_two}}
                         |> Game.get_current_player()

      assert current_player.mark === :x
    end

    test "it is player two's turn after a move is added" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      current_player = %Game{players: {player_one, player_two}}
                         |> Game.mark_cell_for_current_player(0)
                         |> Game.get_current_player() 

      assert current_player.mark === :o
    end

    test "it is player one's turn after two moves are added" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      current_player = %Game{players: {player_one, player_two}}
                         |> Game.mark_cell_for_current_player(0)
                         |> Game.mark_cell_for_current_player(1)
                         |> Game.get_current_player() 

      assert current_player.mark === :x
    end

  end
end
