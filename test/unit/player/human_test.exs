defmodule HumanPlayerTest do
  use ExUnit.Case
  import TestHelpers

  test "fetches the raw user input" do
    player = create_human_player_with_moves(moves: "A1\nA2\n")

    assert Player.Human.fetch_raw_next_move(player) === "A1\n"
    assert Player.Human.fetch_raw_next_move(player) === "A2\n"
  end

  test "converts from cartesian coordinates to linear cell location, example one" do
    board_size = 3
    cartesian = "B1\n"
    linear = 3

    assert Player.Human.parse_cartesian_coordinates(cartesian, board_size) === linear
  end

  test "converts from cartesian coordinates to linear cell location, example two" do
    board_size = 2
    cartesian = "B1\n"
    linear = 2

    assert Player.Human.parse_cartesian_coordinates(cartesian, board_size) === linear
  end

  test "defaults to board size of 3 if not given" do
    cartesian = "B1\n"
    linear = 3

    assert Player.Human.parse_cartesian_coordinates(cartesian) === linear
  end

  test "parses the raw user input into a linear cell location" do
    player_one = create_human_player_with_moves(moves: "A1\n")
    player_two = create_human_player_with_moves(moves: "A2\n")

    game = %Game.Engine{players: {player_one, player_two}, board: %Board{}}

    assert Player.get_next_move(player_one, game) === 0
    assert Player.get_next_move(player_two, game) === 1
  end

end
