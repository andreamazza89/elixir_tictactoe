defmodule PlayGame do

  def main(["human_v_human"]) do
    human_player = %Player.Human{mark: :x}
    linear_cpu_player = %Player.Human{mark: :o}
    game = %Game{players: {human_player, linear_cpu_player}}
    UI.Console.play(game)
  end

  def main(_) do
    game = %Game{}
    UI.Console.play(game)
  end

end
