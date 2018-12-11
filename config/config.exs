# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kanban,
  ecto_repos: [Kanban.Repo]

# Configures the endpoint
config :kanban, KanbanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iXxE1FIv1qosm4oQsvmSiZPaAAXV0nwEulSL44prGW3wBOCzHNr+6YEk+zxdP2rR",
  render_errors: [view: KanbanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Kanban.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Users Guardian
config :kanban, Kanban.Accounts.Guardian,
  issuer: "kanban",
  # put the result of the mix command above here
  secret_key: "GAPFCOOQWUUpDOY22Iyc4LH+cEcnavH+Z3sEC8QZ5Gc3h/94vDZmwtiTH0xQR/DW"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
