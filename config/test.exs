import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :wabanex, Wabanex.Repo,
  database: "wabanex_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wabanex, WabanexWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :junit_formatter,
  report_file: "test_report.xml",
  report_dir: "report/test",
  automatic_create_dir?: true,
  include_filename?: true,
  include_file_line?: true
