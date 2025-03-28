# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ngobrolin,
  ecto_repos: [Ngobrolin.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures the endpoint
config :ngobrolin, NgobrolinWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: NgobrolinWeb.ErrorHTML, json: NgobrolinWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Ngobrolin.PubSub,
  live_view: [signing_salt: "V67mQL8p"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ngobrolin, Ngobrolin.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  ngobrolin: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  ngobrolin: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ngobrolin, :playlist_id, "PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT"

config :ngobrolin, :youtube_api_key, System.get_env("YOUTUBE_API_KEY")
config :ngobrolin, :aws_access_key, System.get_env("AWS_ACCESS_KEY")

config :ex_aws,
  json_codec: Jason,
  access_key_id: {:system, "AWS_ACCESS_KEY_ID"},
  secret_access_key: {:system, "AWS_SECRET_ACCESS_KEY"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
