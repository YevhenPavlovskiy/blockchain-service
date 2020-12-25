defmodule BlockchainService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: BlockchainService.Worker.start_link(arg)
      # {BlockchainService.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: BlockchainService.Router, options: [port: 4001]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlockchainService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
