defmodule Tada do
  @moduledoc """
  Documentation for `Tada`.
  """

  def memorize(text, steps) do
    Tada.Boundary.start_link(text, steps)
  end

  def erase(server) do
    Tada.Boundary.erase(server)
  end
end
