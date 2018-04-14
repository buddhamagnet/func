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
    |> build_grid
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
  Given a hashed value, returns an Identicon.Image with
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

  @doc """
    Given an Identicon.Image, chunks the hex list into
    sets of three and creates a list of mirrored rows.
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Given a list of at least 2 elements, returns a
    mirrored list with the first two elements appended
    in reverse order.
  """
  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end
end
