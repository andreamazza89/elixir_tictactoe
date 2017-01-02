defmodule ItegrationHumanVsHumanTest do
  use ExUnit.Case
  import TestHelpers
  import ExUnit.CaptureIO

  test "player 1 wins, size 3" do
    player_one = create_human_player_with_moves(moves: "A1\nA2\nA3", mark: :x)
    player_two = create_human_player_with_moves(moves: "B1\nB2", mark: :o)
    game = %Game{players: {player_one, player_two}}
    play_game = fn -> Game.Runner.game_loop(game, UI.Console) end

    assert Regex.match?(~r{The winner was: x}, capture_io(play_game))
  end

  test "player 2 wins, size 3" do
    player_one = create_human_player_with_moves(moves: "A1\nB1\nA2", mark: :x)
    player_two = create_human_player_with_moves(moves: "A3\nB3\nC3", mark: :o)
    game = %Game{players: {player_one, player_two}}
    play_game = fn -> Game.Runner.game_loop(game, UI.Console) end

    assert Regex.match?(~r{The winner was: o}, capture_io(play_game))
  end

  test "draw, size 3" do
    player_one = create_human_player_with_moves(moves: "A2\nB2\nB3\nC1\nC3", mark: :x)
    player_two = create_human_player_with_moves(moves: "A1\nA3\nB1\nC2", mark: :o)
    game = %Game{players: {player_one, player_two}}
    play_game = fn -> Game.Runner.game_loop(game, UI.Console) end

    assert Regex.match?(~r{It was a draw!}, capture_io(play_game))
  end

  test "player 1 wins, size 4" do
    player_one = create_human_player_with_moves(moves: "A1\nA2\nA3\nA4", mark: :x)
    player_two = create_human_player_with_moves(moves: "B1\nB2\nB3", mark: :o)
    empty_board = create_board([size: 4, x: [], o: []])
    game = %Game{players: {player_one, player_two}, board: empty_board}
    play_game = fn -> Game.Runner.game_loop(game, UI.Console) end

    assert Regex.match?(~r{The winner was: x}, capture_io(play_game))
  end

end
