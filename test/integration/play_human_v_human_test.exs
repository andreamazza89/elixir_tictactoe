defmodule ItegrationHumanVsHumanTest do
  use ExUnit.Case
  import TestHelpers
  import ExUnit.CaptureIO

  test "full game, player 1 wins" do
    player_one = create_human_player_with_moves(moves: "A1\nB1\nC1", mark: :x)
    player_two = create_human_player_with_moves(moves: "A2\nA3", mark: :o)
    play_function = fn -> UI.Console.play(player_one, player_two) end

    assert Regex.match?(~r{The winner was: x}, capture_io(play_function))
  end

  test "full game, player 2 wins" do
    player_one = create_human_player_with_moves(moves: "A1\nB1\nA2", mark: :x)
    player_two = create_human_player_with_moves(moves: "A3\nB3\nC3", mark: :o)
    play_function = fn -> UI.Console.play(player_one, player_two) end

    assert Regex.match?(~r{The winner was: o}, capture_io(play_function))
  end

  test "full game, draw" do
    player_one = create_human_player_with_moves(moves: "A2\nB2\nB3\nC1\nC3", mark: :x)
    player_two = create_human_player_with_moves(moves: "A1\nA3\nB1\nC2", mark: :o)
    play_function = fn -> UI.Console.play(player_one, player_two) end

    assert Regex.match?(~r{It was a draw!}, capture_io(play_function))
  end

end
