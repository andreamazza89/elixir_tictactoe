defmodule PlayGame do

  def main(_) do
    Game.Engine.play({:stdio, :x}, {:stdio, :o})
  end

end
