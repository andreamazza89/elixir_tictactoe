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

  def announce_winner(winners_mark) do
    IO.puts "The winner was: " <> Atom.to_string(winners_mark)
  end

  def announce_draw do
    IO.puts "It was a draw!"
  end

  def get_next_move(board, input_stream, mark) do
    IO.puts render_board(board, [empty: " ", x: "x", o: "o"] )
    IO.gets(input_stream, "\n") |> String.trim |> parse_move(mark)
  end

  def parse_move(cartesian_cell_location, player_id) do
    row = String.first(cartesian_cell_location)
    column = cartesian_cell_location |> String.last |> String.to_integer
    linear_cell_location = @letter_to_number[row] + (column - 1)
    {linear_cell_location, player_id}
  end

end
