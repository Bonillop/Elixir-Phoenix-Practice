# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, DiscussWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XcT3Vi3rGoN5Ykt+adfl3w3XZvsrATTtJ1icu3/jbbYPc9QRdIcYuKgyNyEIKRPi",
  render_errors: [view: DiscussWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Discuss.PubSub,
  live_view: [signing_salt: "099YfhAv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [] }
  ]

# Correct way using env variables
# config :ueberauth, Ueberauth.Strategy.Github.OAuth,
#   client_id: System.get_env("GITHUB_CLIENT_ID"),
#   client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# TODO: This shouldn't be done as it is insecure, use env variables for api keys
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "4f4058835c2f1b4a25c1",
  client_secret: "8ca5d60beeff8a3641e94222d66b8a876be8a2ec"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
