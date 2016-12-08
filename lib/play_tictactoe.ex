defmodule PlayGame do

  def main(["human_v_human"]) do
    human_player = %Player.Human{mark: :x}
    linear_cpu_player = %Player.Human{mark: :o}
    game = %Game.Engine{players: {human_player, linear_cpu_player}}
    UI.Console.play(game)
  end

  def main(_) do
    game = %Game.Engine{}
    UI.Console.play(game)
  end

end
