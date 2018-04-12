defmodule Identicon do
  @moduledoc """
  Documentation for the Identicon module.
  """
  
  @doc """
  The main function is responsible for taking
  a string ```input``` and converting it into
  an Identicon. The same string will always 
  generate the same Identicon.
  """
  def main(input) do
    input
    |> hash
    |> to_image
    |> pick_colour
  end

  @doc """
  Given a `String`, returns a raw
  MD5 hash of that string, via the `:crypto` Erlang
  package.
  """
  def hash(str) do
    :crypto.hash(:md5, str)
  end

  @doc """
  Given a hashed value, returns a struct with
  a hex property - a list of numbers based on
  the hash bytes.
  """
  def to_image(hash) do
    %Identicon.Image{hex: :binary.bin_to_list(hash)}
  end

  @doc """
  Given an Identicon.Image, returns the first three
  elements in the hex list, representing red, blue
  and green.
  """
  def pick_colour(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | colours: {r, g, b}}
  end
end
