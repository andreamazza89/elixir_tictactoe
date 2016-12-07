defmodule PlayGame do

  def main(_) do
    UI.Console.play({:stdio, :x}, {:stdio, :o})
  end

end
