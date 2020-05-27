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

  # API

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: :counter)
  end

  def inc(counter) do
    GenServer.cast(counter, :inc)
  end

  def get_count(counter) do
    GenServer.call(counter, :get_count)
  end
end
