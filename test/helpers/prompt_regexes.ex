defmodule PromptRegexes do

  def clear_screen_regex do
    ~r{\A\e\[2J\n\e\[H\n}
  end

  def empty_board_regex(game) do
    ~r{#{UI.Console.render_board(game.board, [empty: " "])}}
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

  def play_again_regex do
    ~r{Would you like to play again\? \(y\/n\)}
  end

  def ask_board_size_regex do
    ~r{What size board would you like to play with?}
  end

  def invalid_mode_selected_regex do
    ~r{Invalid mode: please try again. Only 1-6 are available}
  end

  def game_mode_prompt_regex do
    ~r"""
    Please select a game mode \(enter mode number\): 
      1 - human vs human
      2 - human vs dumb machine
      3 - dumb machine vs dumb machine
      4 - human vs clever machine
      5 - dumb machine vs clever machine
      6 - clever machine vs clever machine
    """
  end
end
