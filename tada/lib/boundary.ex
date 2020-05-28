defmodule Tada.Boundary do
  use GenServer

  alias Tada.Passage

  # callbacks

  def init({text, step}) do
    passage = Passage.new(text, step)
    instructions(passage, step)
    {:ok, passage}
  end

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

  defp scroll() do
    "\n"
    |> List.duplicate(40)
    |> IO.puts()
  end
end
