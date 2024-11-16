defmodule TemplateProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
alias DBConnection.App

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      TemplateProjectWeb.Telemetry,
      TemplateProject.Repo,
      {DNSCluster, query: Application.get_env(:template_project, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TemplateProject.PubSub},
      # Start a worker by calling: TemplateProject.Worker.start_link(arg)
      # {TemplateProject.Worker, arg},
      # Start to serve requests, typically the last entry
      TemplateProjectWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TemplateProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl Application
  def config_change(changed, _new, removed) do
    TemplateProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
