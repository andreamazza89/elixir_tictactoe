defmodule StubUserInterfaceWantsHumanVsHumanAndSwap do

  def ask_game_mode(_input_device, _valid_input) do
    :human_v_human
  end

  def ask_swap_play_order(_input_device) do
    true
  end

  def ask_board_size(_input_device, _valid_input) do
    3
  end
end

defmodule StubUserInterfaceWantsHumanVsLinearNoSwap do

  def ask_game_mode(_input_device, _valid_input) do
    :human_v_linear_machine
  end

  def ask_swap_play_order(_input_device) do
    false
  end

  def ask_board_size(_input_device, _valid_input) do
    3
  end
end

defmodule StubUserInterfaceWantsBoardSizeFour do

  def ask_game_mode(_input_device, _valid_input) do
    :linear_machine_v_linear_machine
  end

  def ask_swap_play_order(_input_device) do
    false
  end

  def ask_board_size(_input_device, _valid_input) do
    4
  end
end
