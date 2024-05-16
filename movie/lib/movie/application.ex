defmodule Movie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MovieWeb.Telemetry,
      Movie.Repo,
      {DNSCluster, query: Application.get_env(:movie, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Movie.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Movie.Finch},
      # Start a worker by calling: Movie.Worker.start_link(arg)
      # {Movie.Worker, arg},
      # Start to serve requests, typically the last entry
      MovieWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Movie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MovieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
