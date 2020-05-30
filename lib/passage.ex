defmodule Tada.Passage do
  @moduledoc """
  Contains the code for manipulating the text passage that we want to memorize
  """

  @type t(text_state, plan) :: %__MODULE__{text_state: text_state, plan: plan}
  @type t :: %__MODULE__{text_state: String.t(), plan: list(list(integer))}
  @ignore ["\n", " ", ".", ","]
  defstruct [:text_state, :plan]

  @doc """
  Constructor for the struct
  """
  @spec new(String.t(), integer) :: t()
  def new(text, steps) do
    %__MODULE__{
      text_state: text,
      plan: plan(text, steps)
    }
  end

  @spec erase(t()) :: t()
  def erase(%__MODULE__{ plan: []} = passage), do: passage

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

  defp maybe_replace({char, _}, _) when char in @ignore, do: char

  defp maybe_replace({char, index}, indexes) do
    if index in indexes do
      "_"
    else
      char
    end
  end
end
