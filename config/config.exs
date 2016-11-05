# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :minishop, ecto_repos: [Minishop.Repo]
# Configures the endpoint
config :minishop, Minishop.Endpoint,
  url: [host: "localhost"],
  #  root: Path.dirname(__DIR__),
  secret_key_base: "RSlhQpxDjtW1J2qEZjk26t1t8t/Upbar/VQhNqqEW6kVfBrbmJGxZFZ19p2CYVVr",
  #render_errors: [accepts: ~w(html json)],
  render_errors: [view: Minishop.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Minishop.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false


config :minishop, namespace: Minishop
