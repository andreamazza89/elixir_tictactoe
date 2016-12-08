defmodule StubGameReturnsNoughtsWinner do
  defstruct game: "stub_game" 

  defimpl Game, for: StubGameReturnsNoughtsWinner do
    def status(_game, _board_module) do
      {:win, :o} 
    end
  end

end
