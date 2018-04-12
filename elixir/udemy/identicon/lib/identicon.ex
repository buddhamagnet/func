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
  Given a hashed value ```hash```, returns a struct with
  a hex property - a list of numbers based on the hash bytes.

  ## Examples

      iex> hash = Identicon.hash("dave")
      iex> Identicon.to_image(hash)
      %Identicon.Image{
        hex: [22, 16, 131, 135, 67, 204, 144, 227, 228, 253, 218, 116, 130,
          130, 217, 184]
        } 
  """
  def to_image(hash) do
    %Identicon.Image{hex: :binary.bin_to_list(hash)}
  end

  @doc """
  Given an Identicon.Image ```image```, returns the first three
  elements in the hex list, representing red, blue and green.
  
  ## Examples

      iex> hash = Identicon.hash("dave")
      iex> image = Identicon.to_image(hash)
      iex> Identicon.pick_colour(image)
      [22, 16, 131] 
  """
  def pick_colour(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image
    [r, g, b]
  end
end
