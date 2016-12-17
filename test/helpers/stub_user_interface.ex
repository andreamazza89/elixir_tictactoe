defmodule StubUserInterfaceWantsHumanVsHumanAndSwap do

  def ask_game_mode(input_device) do
    :human_v_human
  end

  def ask_swap_play_order(input_device) do
    true
  end
end

defmodule StubUserInterfaceWantsHumanVsLinearNoSwap do

  def ask_game_mode(input_device) do
    :human_v_linear_machine
  end

  def ask_swap_play_order(input_device) do
    false
  end
end
