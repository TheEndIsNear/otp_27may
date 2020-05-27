defmodule Counter.Boundary do
  use GenServer

  # Callbacks

  def init(initial_count) do
    {:ok, initial_count}
  end

  def handle_call(:get_count, _from, count) do
    {:reply, count, count}
  end

  def handle_cast(:inc, count) do
    {:noreply, Counter.Core.inc(count)}
  end
end
