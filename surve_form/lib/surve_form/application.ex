defmodule SurveForm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SurveForm.Repo,
      # Start the Telemetry supervisor
      SurveFormWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SurveForm.PubSub},
      # Start the Endpoint (http/https)
      SurveFormWeb.Endpoint
      # Start a worker by calling: SurveForm.Worker.start_link(arg)
      # {SurveForm.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurveForm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SurveFormWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
