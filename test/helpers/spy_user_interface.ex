defmodule SpyUserInterface do

  def announce_draw do
    send self, :spy_user_interface_received_announce_draw 
  end

  def announce_winner(:x) do
    send self, :spy_user_interface_received_announce_win_with_player_one 
  end

end
