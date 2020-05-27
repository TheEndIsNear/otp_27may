defmodule Counter.Application do
  use Application

  def start(_type, _args) do
    IO.puts "Starting Counter"
    
    children = [
      {Counter.Boundary, count: 42, name: :c1}, 
      {Counter.Boundary, count: 43, name: :c2}, 
      {Counter.Boundary, count: 44, name: :c3}
    ]

    opts = [strategy: :rest_for_one, name: Counter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
