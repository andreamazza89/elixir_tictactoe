defmodule Player.Human do                                                                                                                                                 
  defstruct stream: :stdio, mark: :x

  @capital_a 65

  def fetch_raw_next_move(player) do
    raw_move = IO.gets(player.stream, "\n") 
    if Regex.match?(~r|^[a-zA-Z]{1}\d$|, raw_move) do
      raw_move
    else
      announce_invalid_input
      fetch_raw_next_move(player)
    end
  end

  def parse_cartesian_coordinates(coordinates, board_size \\ 3) do
    zero_index_adjusted_column = coordinates |> String.trim |> String.last 
                                   |> String.to_integer |> subtract(1)

    row_character = coordinates |> String.first |> String.to_charlist |> List.first
    row_offset = row_character |> offset_from_capital_a() |> times(board_size) 

    zero_index_adjusted_column + row_offset
  end

  defp subtract(number, other_number) do
    number - other_number
  end

  defp times(number, other_number) do
    number * other_number
  end

  defp offset_from_capital_a(character) do
    character - @capital_a
  end

  defp announce_invalid_input do
    IO.puts "Invalid input format: please try again"
  end

end

defimpl Player, for: Player.Human do

  def get_next_move(player, game) do
    raw_move = Player.Human.fetch_raw_next_move(player)
    Player.Human.parse_cartesian_coordinates(raw_move)
  end

end
