# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :template_project,
  ecto_repos: [TemplateProject.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :template_project, TemplateProjectWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: TemplateProjectWeb.ErrorHTML, json: TemplateProjectWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TemplateProject.PubSub,
  live_view: [signing_salt: "Rj7FMTcT"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  template_project: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  template_project: [
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

# Configure opentelemetry
config :opentelemetry,
  resource: [
    service: [
      name: "project_name",
      namespace: "prod"
    ]
  ]

# Configure Oban
config :project_name, Oban,
  repo: ProjectName.Repo,
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24 * 7)},
    {Oban.Plugins.Cron, crontab: []}
  ],
  queues: [default: 10]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
