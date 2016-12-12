defmodule Player.Human do                                                                                                                                                 
  defstruct stream: :stdio, mark: :x

  @capital_a 65

  def fetch_raw_next_move(player) do
    raw_move = IO.gets(player.stream, "\n") 
    if Regex.match?(valid_move_format_regex, raw_move) do
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

  defp valid_move_format_regex(board_size \\ 3) do
    ~r|^[a-zA-Z]{1}[1-#{board_size}]$|
  end

end

defimpl Player, for: Player.Human do

  def get_next_move(player, game) do
    raw_move = Player.Human.fetch_raw_next_move(player)
    parsed_move = Player.Human.parse_cartesian_coordinates(raw_move)
    if Game.is_move_available?(game, parsed_move) do
      parsed_move
    else
      announce_move_already_taken
      get_next_move(player, game) 
    end
  end

  defp announce_move_already_taken do
    IO.puts "Move already taken: please select alternative move"
  end

end
