defmodule Wabanex.MixProject do
  use Mix.Project

  def project do
    [
      app: :wabanex,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
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
      {:absinthe, "~> 1.7.0"},
      {:absinthe_plug, "~> 1.5.0"},
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},
      {:crudry, "~> 2.4.0"},
      {:dialyxir, "~> 1.4.0", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.11.0"},
      {:gettext, "~> 0.24.0"},
      {:jason, "~> 1.4.0"},
      {:junit_formatter, "~> 3.3.0", only: [:test]},
      {:lcov_ex, "~> 0.3.0", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.1.0", only: [:dev, :test], runtime: false},
      {:pg_ranges, "~> 1.1.0"},
      {:phoenix, "~> 1.7.0"},
      {:phoenix_ecto, "~> 4.4.0"},
      {:phoenix_view, "~> 2.0.0"},
      {:phoenix_live_dashboard, "~> 0.8.0"},
      {:plug_cowboy, "~> 2.7.0"},
      {:postgrex, "~> 0.17.0"},
      {:prom_ex, "~> 1.9.0"},
      {:sobelow, "~> 0.12", only: [:dev, :test], runtime: false},
      {:telemetry_metrics, "~> 0.6.0"},
      {:telemetry_poller, "~> 1.0.0"}
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
