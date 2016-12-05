defmodule UI.InputParser do

  @letter_to_number %{"A" => 0, "B" => 3, "C" => 6}

  def parse_move(cartesian_cell_location, player_id) do
    row = String.first(cartesian_cell_location)
    column = cartesian_cell_location |> String.last |> String.to_integer
    linear_cell_location = @letter_to_number[row] + (column - 1)
    {linear_cell_location, player_id}
  end

end
