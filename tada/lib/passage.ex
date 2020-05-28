defmodule Tada.Passage do
  defstruct [:text_state, :chars_to_remove_per_step ]

  def new(text, steps) do
    %__MODULE__{
      text_state: text,
      chars_to_remove_per_step: plan(text, steps)
    }
  end

  defp plan(text, steps) do
    range = String.length(text)
    char_to_del = div(range, steps)
    
    1..range
    |> Enum.shuffle()
    |> Enum.chunk_every(char_to_del)
  end


end
