defmodule CardsTest do
  use ExUnit.Case
  doctest Cards
  # doctest TESTS EXAMPLE BLOCKS FOUND!
  # Tests are FIRST-CLASS CITIZENS

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
    # or refute deck == Cards.shuffle(deck)
  end
end
