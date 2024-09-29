defmodule Chat.MixProject do
  use Mix.Project

  def project do
    [
      app: :chat_infotex,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Chat.Application, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34", runtime: false},
      {:n2o, "~> 11.9"},
      {:nitro, "~> 9.9"},
      {:plug_cowboy, "~> 2.7"},
      {:websock_adapter, "~> 0.5.7"}
    ]
  end
end
