defmodule PushControl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PushControlWeb.Telemetry,
      PushControl.Repo,
      {DNSCluster, query: Application.get_env(:push_control, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PushControl.PubSub},

      # Start the Finch HTTP client for sending emails
      {Finch, name: PushControl.Finch},

      # Start the Quantum job scheduler
      PushControl.Scheduler.Quantum,

      # Start the ETS table
      PushControl.Ets.JobCache,

      # Start a worker by calling: PushControl.Worker.start_link(arg)
      # {PushControl.Worker, arg},

      # Start to serve requests, typically the last entry
      PushControlWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PushControl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PushControlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
