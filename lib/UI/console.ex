defmodule UI.Console do

  @letter_to_number %{"A" => 0, "B" => 3, "C" => 6}
  @visual_board_template "
  1 | 2 | 3 
  ----------
A a | b | c 
  ----------
B d | e | f 
  ----------
C g | h | i "  

  def play(game) do
    do_play(game)
  end

  defp do_play(game) do
    case Game.status(game) do
      {:win, winner} ->
        announce_winner(winner)
      :draw ->
        announce_draw
      :incomplete ->
        announce_next_move(game)
        next_move = get_next_move(game)
        updated_game = Game.mark_cell_for_current_player(game, next_move)
        do_play(updated_game)
    end
  end

  def render_board(%Board{cells: [a,b,c,d,e,f,g,h,i]}, mark_to_string) do
    String.replace(@visual_board_template, "a", mark_to_string[a]) 
     |> String.replace("b", mark_to_string[b]) 
     |> String.replace("c", mark_to_string[c]) 
     |> String.replace("d", mark_to_string[d]) 
     |> String.replace("e", mark_to_string[e]) 
     |> String.replace("f", mark_to_string[f]) 
     |> String.replace("g", mark_to_string[g]) 
     |> String.replace("h", mark_to_string[h]) 
     |> String.replace("i", mark_to_string[i]) 
  end

  defp announce_winner(winners_mark) do
    IO.puts "The winner was: " <> Atom.to_string(winners_mark)
  end

  defp announce_draw do
    IO.puts "It was a draw!"
  end

  defp announce_next_move(game) do
    current_player = Game.get_current_player(game)
    IO.puts "It is " <> Atom.to_string(current_player.mark) <> "'s turn, please pick a move:"
    IO.puts render_board(game.board, [empty: " ", x: "x", o: "o"] )
  end

  defp get_next_move(game) do
    current_player = Game.get_current_player(game)
    Player.get_next_move(current_player, game)
  end

end
