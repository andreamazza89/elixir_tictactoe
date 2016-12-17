defmodule GameReplayTest do
  use ExUnit.Case
  import TestHelpers

  test "program exits at the end of a game" do
    input_stream = create_input_stream("3\ny\nn\n")
    play_game = fn() -> Game.Runner.play(io: {UI.Console, input_stream}) end 

    assert catch_exit(play_game.()) === :game_over
  end

  test "program executes again if the user wants to" do
    input_stream = create_input_stream("3\ny\ny\n3\nn\nn\n")
    play_game = fn() -> Game.Runner.play(io: {UI.Console, input_stream}) end 

    assert catch_exit(play_game.()) === :game_over
  end

end
