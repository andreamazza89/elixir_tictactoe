defmodule PlayGame do

  def main(_) do
    Game.Runner.play(io: {UI.Console, :stdio})
  end

end
