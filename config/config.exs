# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ifrnmessenger,
  ecto_repos: [Ifrnmessenger.Repo]

# Configures the endpoint
config :ifrnmessenger, IfrnmessengerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZRDlAAAIbc8jt8TneEF/cOcKYcP3OXqTvAy8p+qAapZdcJ59SK5L9KKWsRnKLD5s",
  render_errors: [view: IfrnmessengerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ifrnmessenger.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
