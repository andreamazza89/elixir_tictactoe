defmodule GameRunner do

  def setup do
    UI.introduction
    {:ok, state_id} = GameState.start_board
    state_id
  end

  def play(state_id, {get_current_player_move, get_next_player_move}) do
    do_play(state_id, {get_current_player_move, get_next_player_move}) 
  end

  def do_play(state_id, {get_current_player_move, get_next_player_move}) do
    case Board.Evaluation.status(GameState.get_board(state_id)) do
      {:win, winner} ->
        IO.announce_winner(winner, state_id)
      :draw ->
        IO.announce_draw(state_id)
      :incomplete ->
        UI.show_board(state_id)
        next_move = get_current_player_move.()
        GameState.update_board(next_move, state_id)
        do_play(state_id, {get_next_player_move, get_current_player_move})
    end
  end


end

defmodule GameState do

  def start_board do
    Agent.start_link fn -> [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty] end
  end

  def get_board(state_id) do
    Agent.get(state_id, &(&1))
  end

  def update_board(move, state_id) do
    Agent.update(state_id, fn(old_board) -> Board.Manipulation.add_move(old_board, move) end)
  end

end

defmodule UI do

  def show_board(state_id) do
    board = GameState.get_board(state_id)
    IO.puts "here's the board"
    IO.puts Board.Presentation.render(board, [empty: " ", x: "x", o: "o"])
  end
  
  def introduction do
    IO.puts "Introduction to the game"
  end 
  
end
