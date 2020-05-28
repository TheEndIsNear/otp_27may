
defmodule PassageTest do
  use ExUnit.Case
  alias Tada.Passage

  test "passage constructor" do
    assert passage(:short).text_state == "I am happy" 
    assert [[_,_,_,_,_], [_,_,_,_,_]] = passage(:short).chars_to_remove_per_step
  end

  def passage(:short) do
    Passage.new("I am happy", 2)
  end
end
