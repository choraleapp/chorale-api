defmodule ChoraleApi.Mixfile do
  use Mix.Project

  def project do
    [app: :chorale_api,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
	[
		applications: [:logger, :mongodb, :poolboy, :plug, :cowboy],
		mod: {ChoraleApi.Supervisor, []}
	]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
		{:plug, "~> 1.4"},
		{:cowboy, "~> 1.1"},
		{:mongodb, "~> 0.4.3"},
		{:mailer, "~> 1.3"},
		{:poolboy, "~> 1.5"}
	]
  end
end
