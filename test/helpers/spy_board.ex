defmodule SpyBoard do
  def status(_) do
    send self, :spy_board_received_status_call
  end
end
