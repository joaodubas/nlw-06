defmodule Wabanex.MixProject do
  use Mix.Project

  def project do
    [
      app: :wabanex,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      dialyzer: [plt_core_path: "priv/plts"],
      test_coverage: [tool: LcovEx, output: "cover"],
      preferred_cli_env: [lcov: :test],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Wabanex.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:absinthe, "~> 1.5"},
      {:absinthe_plug, "~> 1.5"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:crudry, "~> 2.4.0"},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.4"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.0"},
      {:junit_formatter, "~> 3.1", only: [:test]},
      {:lcov_ex, "~> 0.2", only: [:dev, :test], runtime: false},
      {:pg_ranges, "~> 1.1"},
      {:phoenix, "~> 1.6.0"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:prom_ex, "~> 1.7"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
