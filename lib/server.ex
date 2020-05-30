defmodule Tada.Server do
  @moduledoc """
  The server module contains all of the GenServer logic for the project.
  """
  use GenServer

  alias Tada.Passage

  # API

  @spec start_link({atom, String.t(), integer}) ::
          {:ok, pid()} | :ignore | {:error, {:already_started, pid()} | term()}
  def start_link({name, text, steps}) do
    GenServer.start_link(__MODULE__, {text, steps}, name: name)
  end

  @spec erase(pid) :: :ok
  def erase(server) do
    server
    |> GenServer.call(:erase)
    |> inform()
  end

  # callbacks

  @impl true
  @spec init({String.t(), integer}) ::
          {:ok, state}
          | {:ok, state, timeout() | :hibernate | {:continue, term()}}
          | :ignore
          | {:stop, reason :: any()}
        when state: any()
  def init({text, step}) do
    passage = Passage.new(text, step)
    instructions(passage, step)
    {:ok, passage}
  end

  @impl true
  def handle_call(:erase, _from, passage) do
    passage = Passage.erase(passage)
    {:reply, passage.text_state, passage}
  end

  defp instructions(passage, step) do
    scroll()
    IO.puts("Memorize this passage in #{step} steps.")
    IO.puts(" ")
    IO.puts(passage.text_state)
  end

  defp scroll do
    "\n"
    |> List.duplicate(40)
    |> IO.puts()
  end

  defp inform(text) do
    scroll()
    IO.puts("")
    IO.puts(text)
  end

  def child_spec({name, text, steps}) do
    %{
      id: name,
      start: {Tada.Server, :start_link, [{name, text, steps}]}
    }
  end
end
