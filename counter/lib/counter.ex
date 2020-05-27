defmodule Counter do
alias Counter.Boundary
  def start_link(count) when is_number(count) do
    Boundary.start_link(count)
  end

  def inc(counter) do
    Boundary.inc(counter)
  end

  def get_count(counter) do
    Boundary.get_count(counter)
  end
  
  def kill(counter) do
    Boundary.kill(counter)
  end

end
