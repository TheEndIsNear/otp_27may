defmodule TadaTest do
  use ExUnit.Case
  doctest Tada

  test "greets the world" do
    assert Tada.hello() == :world
  end
end
