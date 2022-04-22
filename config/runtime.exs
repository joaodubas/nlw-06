import Config

config :wabanex, Wabanex.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASS") || "postgres",
  hostname: System.get_env("POSTGRES_HOST") || "localhost"
