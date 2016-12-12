[![Build Status](https://travis-ci.org/andreamazza89/elixir_tictactoe.svg?branch=master)](https://travis-ci.org/andreamazza89/elixir_tictactoe) 
[![Coverage Status](https://coveralls.io/repos/github/andreamazza89/elixir_tictactoe/badge.svg?branch=master)](https://coveralls.io/github/andreamazza89/elixir_tictactoe?branch=master)
# ElixirTictactoe 

An implementation of the [classic tictactoe game](https://en.wikipedia.org/wiki/Tic-tac-toe)
written in Elixir. This is as part of my apprenticeship at [8th Light](https://8thlight.com/)
to get familiar with the language and the functional programming paradigm.

### Installation

- Install Elixir on your machine (see on the [Elixir-lang website](http://elixir-lang.org/install.html)).
- Clone this repo `git clone https://github.com/andreamazza89/elixir_tictactoe`
- Move into the root of the repo `cd elixir_tictactoe` and start the game `./elixir_tictactoe`

### Summary of changes since version 0.1.0

- Game mode selection: the user is prompted to select a game mode. Available modes
are: Human v Human, Human v Machine, Machine v Machine.
- Linear cpu Player: this computer player simply chooses the first move available
on the board.
- The linear cpu player has a 1s standby for better game flow.
- Screen clearing: the program now clears the console before prompts; this makes 
the interface cleaner and also makes the board look as though it is being updated
rather than printed again.
- Input validation: the console input is now validated as necessary. If the user
enters invalid input, the program will prompt again.
- Updated program design: the UI.console module now only interacts with
the Game module. The Player protocol is introduced to create a common interface 
for the game to interact with, regardless of the specific type of player (duck
typing). Also, name-spacing was consolidated to have less granularity.

##### Suggested improvements

- Printing the final board once the game is finished. Currently the prompt that
announces a winner simply states who won before exiting the program. It would be 
nice if the final board was also shown.
- Play again: currently the program only runs through one game, but it might be 
desirable to have a prompt that asks the user if they want to play again or exit.
- Minimax cpu player: add the option to play against an unbeatable player.
