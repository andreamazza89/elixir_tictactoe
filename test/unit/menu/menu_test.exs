defmodule UI.MenuTest do
  use ExUnit.Case

  test "creates a Human v Human game" do
    game = Menu.create_game([mode: :human_v_human, swap_order: false])

    {%Player.Human{}, %Player.Human{}} = game.players
  end

  test "creates a Human v Machine game" do
    game = Menu.create_game([mode: :human_v_linear_machine, swap_order: false])

    {%Player.Human{}, %Player.LinearCpu{}} = game.players
  end

  test "creates a Machine v Machine game" do
    game = Menu.create_game([mode: :linear_machine_v_linear_machine, swap_order: false])

    {%Player.LinearCpu{}, %Player.LinearCpu{}} = game.players
  end

  test "swaps the player's order" do
    game = Menu.create_game([mode: :human_v_linear_machine, swap_order: true])

    {%Player.LinearCpu{}, %Player.Human{}} = game.players
  end

end
