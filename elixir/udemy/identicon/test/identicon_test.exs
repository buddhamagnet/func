defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash to image" do
    image = Identicon.to_image("decimate")
    assert image.hex == [179, 244, 247, 32, 65, 113, 252, 85, 250, 49, 86, 40, 108, 199, 135, 17]
  end

  test "pick colour" do
    image = Identicon.pick_colour(%Identicon.Image{hex: ["red", "green", "blue", "azure"]})
    assert image.colour == {"red", "green", "blue"}
  end

  test "mirror_row" do
    assert Identicon.mirror_row([1, 2, 3]) == [1, 2, 3, 2, 1]
  end

  test "build_grid" do
    image = %Identicon.Image{colour: {179, 244, 247}, hex: [1, 2, 3, 4, 5, 6]}

    assert Identicon.build_grid(image) == %Identicon.Image{
             colour: {179, 244, 247},
             grid: [
               {1, 0},
               {2, 1},
               {3, 2},
               {2, 3},
               {1, 4},
               {4, 5},
               {5, 6},
               {6, 7},
               {5, 8},
               {4, 9}
             ],
             hex: [1, 2, 3, 4, 5, 6]
           }
  end

  test "filter odd numbers" do
    image = %Identicon.Image{
      colour: {179, 244, 247},
      hex: [1, 2, 3, 4, 5, 6],
      grid: [{1, 0}, {2, 1}, {3, 2}, {4, 3}, {5, 4}]
    }

    assert Identicon.filter_odd(image) === %Identicon.Image{
             colour: {179, 244, 247},
             hex: [1, 2, 3, 4, 5, 6],
             grid: [{2, 1}, {4, 3}]
           }
  end

  test "build_pixel_map" do
    image = %Identicon.Image{
      colour: {179, 244, 247},
      hex: [1, 2, 3, 4, 5, 6],
      grid: [{2, 1}, {4, 3}]
    }

    assert Identicon.build_pixel_map(image) === %Identicon.Image{
             colour: {179, 244, 247},
             hex: [1, 2, 3, 4, 5, 6],
             grid: [{2, 1}, {4, 3}],
             pixel_map: [{{50, 0}, {100, 50}}, {{150, 0}, {200, 50}}]
           }
  end

  test "draw_image" do
    image = %Identicon.Image{
      colour: {179, 244, 247},
      hex: [1, 2, 3, 4, 5, 6],
      grid: [{2, 1}, {4, 3}],
      pixel_map: [{{50, 0}, {100, 50}}, {{150, 0}, {200, 50}}]
    }

    assert Identicon.draw_image(image) == true
  end
end
