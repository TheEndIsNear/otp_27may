defmodule Tada do
  @moduledoc """
  The main api layer for the Tada Application
  """
  alias Tada.{Content, Server}

  def add_memorizer(name, steps \\ 5) do
    add_memorizer(name, Content.passage(name), steps)
  end

  def add_memorizer(name, text, steps) do
    DynamicSupervisor.start_child(
      Tada.DynamicSupervisor,
      Server.child_spec({name, text, steps})
    )
  end

  def erase(server_name) do
    Server.erase(server_name)
  end
end
