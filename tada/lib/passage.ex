defmodule Tada.Passage do
  defstruct [:text_state, :plan]

  def new(text, steps) do
    %__MODULE__{
      text_state: text,
      plan: plan(text, steps)
    }
  end

  def erase(%__MODULE__{text_state: text, plan: [head | tail]} = passage) do
    %__MODULE__{passage | text_state: remove_characters(text, head), plan: tail}
  end

  defp plan(text, steps) do
    range = String.length(text)
    char_to_del = div(range, steps)

    1..range
    |> Enum.shuffle()
    |> Enum.chunk_every(char_to_del)
  end

  defp remove_characters(text, step) do
    text
    |> String.graphemes()
    |> Enum.with_index(1)
    |> Enum.map(fn tuple -> maybe_replace(tuple, step) end)
    |> Enum.join()
  end

  defp maybe_replace({char, index}, indexes) do
    if index in indexes do
      "_"
    else
      char
    end
  end
end
