defmodule ItegrationMachineVsMachineTest do
  use ExUnit.Case
  import TestHelpers

  test "program exits at the end of a game" do
    input_stream = create_input_stream("3\ny\nn\n")
    play_game = fn() -> Game.Runner.play(io: {UI.Console, input_stream}) end 

    assert catch_exit(play_game.()) === :game_over
  end

  test "program executes again if the user wants to" do
    input_stream = create_input_stream("y\nn\n")
    game = GameFactory.create_game([mode: :linear_machine_v_linear_machine, swap_order: false]) 
    play_game = fn() -> Game.Runner.play(game, input_stream) end 

    assert catch_exit(play_game.()) === :game_over
  end

end
