defmodule Counter do
alias Counter.Server
  def start(count) when is_number(count) do
    Server.start(count)
  end

  def inc(counter) do
    send(counter, :inc)
  end

  def get_count(counter) do
    send(counter, {:get_count, self()})
    receive do
      count -> count
    end
  end

end
