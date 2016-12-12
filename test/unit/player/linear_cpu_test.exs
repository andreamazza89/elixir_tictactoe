defmodule LinearCpuPlayerTest do
  use ExUnit.Case
  import TestHelpers

  test "chooses the first move available example one" do
    test_player = %Player.LinearCpu{}
    double_player = "double_player"
    board = create_board([x: [], o: []])
    game = %Game.Engine{board: board, players: {test_player, double_player}}

    assert Player.get_next_move(test_player, game) === 0
  end

  test "chooses the first move available example two" do
    test_player = %Player.LinearCpu{}
    double_player = "double_player"
    board = create_board([x: [1], o: []])
    game = %Game.Engine{board: board, players: {test_player, double_player}}

    assert Player.get_next_move(test_player, game) === 1
  end

end
