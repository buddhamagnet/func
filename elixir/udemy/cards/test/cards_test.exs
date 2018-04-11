defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  setup_all do
    {:ok, deck: Cards.create_deck}
  end

  test "create deck", state do
    assert is_list state[:deck]
  end

  test "create deck creates 52 cards", state do
    assert length(state[:deck]) == 52
  end

  test "shuffle deck returns a list", state do
    assert is_list Cards.shuffle(state[:deck])
  end

  test "deal hand", state do
    assert Cards.deal(state[:deck], 1) == ["Ace of Hearts"]
  end

  test "contains", state do
    assert Cards.contains?(state[:deck], "Ace of Hearts") == true
  end

  test "does not contain", state do
    assert Cards.contains?(state[:deck], "Ace of Decimation") == false
  end
end
