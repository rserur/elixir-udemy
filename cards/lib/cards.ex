defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # "Comprehension" over a list = map
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

    iex> deck = Cards.create_deck
    iex> Cards.contains?(deck, "Ace of Spades")
    true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  # Returns tuple
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be the hand.

  ## Examples

    iex> deck = Cards.create_deck
    iex> { hand, deck } = Cards.deal(deck, 1)
    iex> hand
    ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # encodes to savable format w/erlang function
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term binary
      # underscore, don't care about variable later on
      # need throwaway variable for pattern-matching
      { :error, _reason } -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    # Each function in pipe passes results on as first
    # argument to next function
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end

# Wherever possible, delegate to existing methods

# Our Code >>---feeds into---> Elixir >>---transpiles into--->
# Erlang >>---compiled and executed on---> BEAM
# BEAM = Bogdan/Bjorn's Erlang Abstract Machine = Erlang VM
