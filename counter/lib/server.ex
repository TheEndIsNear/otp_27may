defmodule Counter.Server do
  def listen(count) do
    receive do
      :inc ->
        count |> Counter.Core.inc()
      {:get_count, pid} ->
        send(pid, count)
        count
    end
  end

  def run(count) do
    count
    |> listen()
    |> run()
  end

  def start(initial_count) do
    spawn(fn -> run(initial_count) end)
  end
end