defmodule StubGameReturnsDraw do
  defstruct game: "stub_game" 

  defimpl Game, for: StubGameReturnsDraw do
    def status(_game, _board_module) do
      :draw
    end
  end

end
