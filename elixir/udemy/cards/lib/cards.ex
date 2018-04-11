defmodule Cards do

  @moduledoc """
    This module models a pack of cards
    and provides methods for creating and
    handling the deck.
  """

  @doc """
    Returns a list of strings representing
    a deck of cards.
  """
  def create_deck do
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "King",
      "Queen"
    ]

    for s <- suits,
        v <- values do
      "#{v} of #{s}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Divides a deck into a hand. The `size`
    argument indicates how many cards should
    be dealt.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.deal(deck, 1)
      ["Ace of Hearts"]
  """
  def deal(deck, size) do
    elem(Enum.split(deck, size), 0)
  end

  def decimate(size) do
    create_deck() |> shuffle() |> deal(size)
  end

  @doc """
    Indicates whether a given card is
    contained within the pack.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write("data/#{filename}", binary)
  end

  def file_error(reason) do
    case reason do
      :enoent -> %{:code => "404", :message => "File does not exist"}
      :eacces -> %{:code => "403", :message => "Permission denied"}
      :eisdir -> %{:code => "400", :message => "File is a directory"}
      :enomem -> %{:code => "500", :message => "Memory error"}
    end
  end

  def load(filename) do
    case File.read("data/#{filename}") do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> file_error(reason)
    end
  end
end
