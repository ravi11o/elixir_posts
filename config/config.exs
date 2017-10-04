# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixirposts,
  ecto_repos: [Elixirposts.Repo]

# Configures the endpoint
config :elixirposts, ElixirpostsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0cCP13TXIH3jfZpCIExPpkZAJXImjMbxV6DiejEwC//8tkrE/EGxz/EDVWiRXMO7",
  render_errors: [view: ElixirpostsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Elixirposts.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Config scrivener_html
config :scrivener_html,
  routes_helper: ElixirpostsWeb.Router.Helpers

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
