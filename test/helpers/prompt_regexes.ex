defmodule PromptRegexes do

  def clear_screen_regex do
    ~r{\A\e\[2J\n\e\[H\n}
  end

  def empty_board_regex(game) do
    ~r{#{UI.Console.render_board(game.board, [empty: " "])}\Z}
  end

  def next_move_prompt_regex do
    ~r{It is x's turn, please pick a move:}
  end

  def announce_winner_regex(winner) do
    ~r{The winner was: #{Atom.to_string(winner.mark)}}
  end

  def announce_draw_regex do
    ~r{It was a draw!} 
  end
end
