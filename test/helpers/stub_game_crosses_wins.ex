defmodule StubGameReturnsCrossesWinner do
  defstruct game: "stub_game" 

  defimpl Game, for: StubGameReturnsCrossesWinner do
    def status(_game, _board_module) do
      {:win, :x} 
    end
  end

end
