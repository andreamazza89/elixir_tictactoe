defmodule UI.InputParserTest do
  use ExUnit.Case

  test "converts the user's input into a move (example one)" do
    assert UI.InputParser.parse_move("A1", :x) === {0, :x}
  end

  test "converts the user's input into a move (example two)" do
    assert UI.InputParser.parse_move("A1", :o) === {0, :o}
  end

  test "converts the user's input into a move (example three)" do
    assert UI.InputParser.parse_move("A2", :o) === {1, :o}
  end

end
