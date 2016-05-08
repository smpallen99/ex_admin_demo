# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :ex_admin_demo, ExAdminDemo.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "+EYBCh/dYNlCrLsLUmgbLJF81vJfYX4UQmu6ykPORkiCmmalhDJf1XpBDJ3wpQuR",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ExAdminDemo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_admin,
  repo: ExAdminDemo.Repo,
  module: ExAdminDemo,
  # theme: ExAdmin.Theme.ActiveAdmin,
  # head_template: {ExAdminDemo.AdminView, "admin_layout.html"},
  theme_selector: [
    {"AdminLte",  ExAdmin.Theme.AdminLte2},
    {"ActiveAdmin", ExAdmin.Theme.ActiveAdmin}
  ],
  modules: [
    ExAdminDemo.ExAdmin.Dashboard,
    ExAdminDemo.ExAdmin.Product,
    ExAdminDemo.ExAdmin.User,
    ExAdminDemo.ExAdmin.Order
]


# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

config :xain, :quote, "'"
config :xain, :after_callback, {Phoenix.HTML, :raw}

config :arc, bucket: "exadmindemo"
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
