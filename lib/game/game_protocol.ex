defprotocol Game do
  
  def status(game, board_module \\ Board)
  def get_current_player(game)
  def mark_cell_for_current_player(game, cell_to_mark)
  def make_next_move(game)

end
