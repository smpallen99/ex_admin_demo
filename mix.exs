defmodule ExAdminDemo.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_admin_demo,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {ExAdminDemo, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_haml, :ex_aws, :httpoison, :ex_admin, :ex_queb,
                    :phoenix_ecto, :postgrex]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1"},
     {:phoenix_ecto, "~> 3.0.0-rc", override: true},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:phoenix_haml, "~> 0.2"},
     {:calliope, "~> 0.4"},
     # {:scrivener, "~> 1.1.4", override: true},
     # {:ex_queb, path: "../ex_queb", override: true},
     # {:ex_admin, github: "smpallen99/ex_admin", branch: "new_xain2"},
     # {:ex_admin, "~> 0.7"},
     {:ex_admin, path: "../ex_admin7"},
     {:arc,  "~> 0.5.1"},
     {:arc_ecto, "~> 0.3.2"},
     {:ex_aws, "~> 0.4.10"}, # Required if using Amazon S3
     {:httpoison, "~> 0.7"},  # Required if using Amazon S3
     # {:ecto, "~> 1.1.2", override: true},
     {:ecto, "~> 2.0.0-rc.3", override: true},
     {:faker, "~> 0.6.0"},
     {:number, "~> 0.4.1"},
     # {:xain, path: "../xain", override: true},
     {:cowboy, "~> 1.0"}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
