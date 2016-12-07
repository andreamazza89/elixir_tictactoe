defmodule UI.Console do

  @letter_to_number %{"A" => 0, "B" => 3, "C" => 6}

  def announce_winner(winners_mark) do
    IO.puts "The winner was: " <> Atom.to_string(winners_mark)
  end

  def announce_draw do
    IO.puts "It was a draw!"
  end

  def get_next_move(board, input_stream, mark) do
    IO.puts Board.Presentation.render(board, [empty: " ", x: "x", o: "o"] )
    IO.gets(input_stream, "\n") |> String.trim |> parse_move(mark)
  end

  def parse_move(cartesian_cell_location, player_id) do
    row = String.first(cartesian_cell_location)
    column = cartesian_cell_location |> String.last |> String.to_integer
    linear_cell_location = @letter_to_number[row] + (column - 1)
    {linear_cell_location, player_id}
  end

end
