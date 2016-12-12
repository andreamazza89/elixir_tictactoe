defmodule UI.MenuTest do
  use ExUnit.Case

  test "creates a Human v Human game" do
    game = Menu.create_game([mode: :human_v_human, swap_order: false])
    {%Player.Human{}, %Player.Human{}} = game.players
  end

  test "assigns marks in a Human v Human game" do
    game = Menu.create_game([mode: :human_v_human, swap_order: false])
    {player_one, player_two} = game.players
    assert player_one.mark === :x
    assert player_two.mark === :o
  end

  test "creates a Human v Machine game" do
    game = Menu.create_game([mode: :human_v_linear_machine, swap_order: false])
    {%Player.Human{}, %Player.LinearCpu{}} = game.players
  end

  test "assigns marks to the players" do
    game = Menu.create_game([mode: :human_v_linear_machine, swap_order: false])
    {player_one, player_two} = game.players
    assert player_one.mark === :x
    assert player_two.mark === :o
  end

  test "creates a Machine v Machine game" do
    game = Menu.create_game([mode: :linear_machine_v_linear_machine, swap_order: false])
    {%Player.LinearCpu{}, %Player.LinearCpu{}} = game.players
  end

  test "assigns marks in a Machine v Machine game" do
    game = Menu.create_game([mode: :linear_machine_v_linear_machine, swap_order: false])
    {player_one, player_two} = game.players
    assert player_one.mark === :x
    assert player_two.mark === :o
  end

  test "swaps the player's order" do
    game = Menu.create_game([mode: :human_v_linear_machine, swap_order: true])
    {%Player.LinearCpu{}, %Player.Human{}} = game.players
  end

end
