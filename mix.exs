defmodule ElixirRomanNumerals.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_tictactoe,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: [main_module: PlayGame],
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/helpers"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [{:mix_test_watch, "~> 0.2", only: :dev}]
  end
end
