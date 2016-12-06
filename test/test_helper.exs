ExUnit.start()

defmodule TestHelpers do

  @empty_board [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]
  @no_winner_no_draw [:x,:empty,:o,:empty,:x,:empty,:empty,:empty,:empty]
  @crosses_wins_row [:x,:x,:x,:o,:o,:empty,:empty,:empty,:empty]
  @crosses_wins_column [:x,:empty,:o,:x,:o,:empty,:x,:empty,:empty]
  @crosses_wins_diagonal [:x,:empty,:o,:o,:x,:empty,:empty,:empty,:x]
  @noughts_wins [:o,:o,:o,:x,:x,:empty,:empty,:empty,:empty]
  @draw [:x,:o,:x,:x,:o,:o,:o,:x,:x]


  def get_cell_at(index, game_state_id) do
    board = Game.StateManager.get_board(game_state_id)
    Enum.at(board, index)
  end

  def create_input_stream(lines) do
    {:ok, input_stream} = StringIO.open(lines) 
    input_stream
  end

  def empty_board do
    @empty_board
  end

  def no_winner_no_draw do
    @no_winner_no_draw
  end

  def crosses_wins_row do
    @crosses_wins_row
  end

  def crosses_wins_column do
    @crosses_wins_column
  end

  def crosses_wins_diagonal do
    @crosses_wins_diagonal
  end

  def noughts_wins do
    @noughts_wins
  end

  def draw do
    @draw
  end

end

