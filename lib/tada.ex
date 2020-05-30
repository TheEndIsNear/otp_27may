defmodule Tada do
  @moduledoc """
  Documentation for `Tada`.
  """

  def add_memorizer(name, steps \\ 5) do
    add_memorizer(name, Tada.Content.passage(name), steps)
  end

  def add_memorizer(name, text, steps) do
    DynamicSupervisor.start_child(
      Tada.DynamicSupervisor,
      Tada.Boundary.child_spec({name, text, steps})
    )
  end

  def erase(server) do
    Tada.Boundary.erase(server)
  end
end
