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
    |> to_image
    |> pick_colour
    |> build_grid
    |> filter_odd
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  Given a string, returns an Identicon.Image with
  a hex property - a list of numbers based on
  the hashed value of the strings.
  """
  def to_image(str) do
    hex =
      :crypto.hash(:md5, str)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  @doc """
  Given an Identicon.Image, returns the first three
  elements in the hex list, representing red, blue
  and green.
  """
  def pick_colour(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | colour: {r, g, b}}
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
    Given an Identicon.Image with a grid, returns
    an Identicon.Image with a grid with the odd
    numbered squares filtered out.
  """
  def filter_odd(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Given an Identicon.Image, builds a pixel map from the
    grid and returns a new image with a pixel_map key.
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        x = rem(index, 5) * 50
        y = div(index, 5) * 50
        top_left = {x, y}
        bottom_right = {x + 50, y + 50}
        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
    Given an Identicon.Image, uses the Erlang EGD
    library to draw and fill and image using the
    Identicon.Image colours and pixel_map keys and
    renders the image.
  """
  def draw_image(%Identicon.Image{colour: colour, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(colour)
    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end
    :egd.render(image)
  end

  def save_image(image, filename) do
    File.write("#{filename}.png", image)    
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
