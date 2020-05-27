defmodule Counter.Boundary do
  use GenServer

  # Callbacks

  def init(initial_count) do
    IO.puts("Initializing with count: #{initial_count}")
    {:ok, initial_count}
  end

  def handle_call(:get_count, _from, count) do
    {:reply, count, count}
  end
  
  def handle_cast(:boom, count) do
    raise "Boom! with #{count}"
    {:noreply, count}
  end

  def handle_cast(:inc, count) do
    {:noreply, Counter.Core.inc(count)}
  end

  # API

  def start_link({name, initial_value}) do
    IO.inspect "Starting counter with name: #{name} and value: #{initial_value}"
    
    GenServer.start_link(__MODULE__, initial_value, name: name)
  end

  def inc(counter) do
    GenServer.cast(counter, :inc)
  end

  def get_count(counter) do
    GenServer.call(counter, :get_count)
  end
  
  def kill(counter) do
    GenServer.cast(counter, :boom)
  end
  
  def child_spec(count: count, name: name) do
    %{
      id: name, 
      start: {Counter.Boundary, :start_link, [{name, count}]}, 
      name: name
    }
  end
end
