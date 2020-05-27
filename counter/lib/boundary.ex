defmodule Counter.Boundary do
  use GenServer

  # Callbacks

  def init(initial_count) do
    IO.inspect "Initializing..."
    IO.inspect "Initial count: #{initial_count}"
    {:ok, initial_count}
  end

  def handle_call(:get_count, _from, count) do
    {:reply, count, count}
  end

  def handle_cast(:inc, count) do
    {:noreply, Counter.Core.inc(count)}
  end

  # API

  def start_link({name, initial_value}) do
    IO.inspect "Starting with name: #{name}"
    IO.inspect "Initial value: #{initial_value}"
    
    GenServer.start_link(__MODULE__, initial_value, name: name)
  end

  def inc(counter) do
    GenServer.cast(counter, :inc)
  end

  def get_count(counter) do
    GenServer.call(counter, :get_count)
  end
  
  def child_spec(count: count, name: name) do
    %{
      id: name, 
      start: {Counter.Boundary, :start_link, [{name, count}]}, 
      name: name
    }
  end
end
