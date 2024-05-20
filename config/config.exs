# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pepicrft, :metadata,
  title: "Pedro Piñera",
  description: "Open and human tech craftsmanship from Berlin",
  domain: "pepicrft.me",
  base_url: "https://pepicrft.me" |> URI.parse(),
  github_url: "https://github.com/pepicrft",
  language: "en-us",
  twitter_handle: "@pepicrft",
  mastodon_url: "https://mastodon.social/@pepicrft",
  linkedin_url: "https://www.linkedin.com/in/pedro-pi%C3%B1era-buendia-9765a9125/",
  author: "Pedro Piñera"

config :pepicrft,
  ecto_repos: [Pepicrft.Repo]

# Configures the endpoint
config :pepicrft, PepicrftWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [
      html: PepicrftWeb.ErrorHTML
    ]
  ],
  pubsub_server: Pepicrft.PubSub,
  live_view: [signing_salt: "KU0gOAcJ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :pepicrft, Pepicrft.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
