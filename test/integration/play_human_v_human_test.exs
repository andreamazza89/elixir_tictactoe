defmodule ItegrationHumanVsHumanTest do
  use ExUnit.Case
  import TestHelpers
  import ExUnit.CaptureIO

  test "full game, player 1 wins" do
    player_one_stream = create_input_stream("A1\nB1\nC1")
    player_two_stream = create_input_stream("A2\nA3")
    play_function = fn -> UI.Console.play({player_one_stream, :x}, {player_two_stream, :o}) end

    assert Regex.match?(~r{The winner was: x}, capture_io(play_function))
  end

  test "full game, player 2 wins" do
    player_one_stream = create_input_stream("A1\nB1\nA2")
    player_two_stream = create_input_stream("A3\nB3\nC3")
    play_function = fn -> UI.Console.play({player_one_stream, :x}, {player_two_stream, :o}) end

    assert Regex.match?(~r{The winner was: o}, capture_io(play_function))
  end

  test "full game, draw" do
    player_one_stream = create_input_stream("A2\nB2\nB3\nC1\nC3")
    player_two_stream = create_input_stream("A1\nA3\nB1\nC2")
    play_function = fn -> UI.Console.play({player_one_stream, :x}, {player_two_stream, :o}) end

    assert Regex.match?(~r{It was a draw!}, capture_io(play_function))
  end

end
