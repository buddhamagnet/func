defmodule Canonical do
  @moduledoc """
  Documentation for Canonical.
  """

  @doc """
  Given a string ```str```, returns a SHA1 hash
  of the string.
  """
  def hash(str) do
    :crypto.hash(:sha, str)
  end

  @doc """
  Given a string ```hash```, returns a base 32
  encoded representation of the string.
  """
  def encode(hash) do
    Base.hex_encode32(hash)
  end

  @doc """
    Given a string ```str```, returns a lowercased,
    base 32 encoded SHA1 hash, to be used as a unique
    identifier (tegID) in the content platform.

  ## Examples

      iex> Canonical.id("economist/node/21724748")
      "bueddagd6m9iugkd3kkt64q5mp1jq1s9"
  """
  def id(str) do
    hash(str) |> encode |> String.downcase
  end
end

