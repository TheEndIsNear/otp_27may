defmodule PassageTest do
  use ExUnit.Case
  alias Tada.Passage

  test "passage constructor" do
    assert passage(:short).text_state == "I am happy"
    assert [[_, _, _, _, _], [_, _, _, _, _]] = passage(:short).plan
  end

  test "reduces intermediate step" do
    passage = passage(:intermediate)
    actual = Passage.erase(passage)

    expected = %Passage{
      text_state: "_2_45",
      plan: []
    }

    assert actual == expected
  end

  test "newlines should remain constant" do
    passage = passage(:newline)
    actual = Passage.erase(passage)

    expected = %Passage{
      text_state: "1_3\n56",
      plan: [[5, 6]]
    }

    assert actual == expected
  end

  test "when the plan is empty return the text" do
    passage = passage(:final)
    actual = Passage.erase(passage)

    expected = %Passage{
      text_state: "_____",
      plan: []
    }

    assert actual == expected
  end

  def passage(:short) do
    Passage.new("I am happy", 2)
  end

  def passage(:intermediate) do
    %Passage{
      text_state: "12345",
      plan: [[1, 3]]
    }
  end

  def passage(:newline) do
    %Passage{
      text_state: "123\n56",
      plan: [[2, 4], [5, 6]]
    }
  end

  def passage(:final) do
    %Passage{
      text_state: "_____",
      plan: []
    }
  end
end
