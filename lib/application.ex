defmodule Tada.Application do
  @moduledoc """
  Module containing the instructions for starting up the application.
  """
  use Application

  def start(_type, _args) do
    IO.puts("Starting TADA...")

    children = [
      {
        DynamicSupervisor,
        strategy: :one_for_one, name: Tada.DynamicSupervisor
      }
    ]

    opts = [strategy: :one_for_one, name: Tada.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
