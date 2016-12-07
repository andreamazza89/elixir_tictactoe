defmodule PlayGame do

  def main(_) do
    game = %Game{}
    UI.Console.play(game)
  end

end
