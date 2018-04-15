defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash to image", state do
    image = Identicon.to_image("decimate")
    assert image.hex == [179, 244, 247, 32, 65, 113, 252, 85, 250, 49, 86, 40, 108, 199, 135, 17]
  end

  test "pick colour" do
    image = Identicon.pick_colour(%Identicon.Image{hex: ["red", "green", "blue", "azure"]})
    assert image.colours == {"red", "green", "blue"}
  end

  test "mirror_row" do
    assert Identicon.mirror_row([1, 2, 3]) == [1, 2, 3, 2, 1]
  end

  test "build_grid" do
    image = %Identicon.Image{colours: {179, 244, 247}, hex: [1, 2, 3, 4, 5, 6]}

    assert Identicon.build_grid(image) == %Identicon.Image{
             colours: {179, 244, 247},
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
      colours: {179, 244, 247},
      hex: [1, 2, 3, 4, 5, 6],
      grid: [{1, 0}, {2, 1}, {3, 2}, {4, 3}, {5, 4}]
    }

    assert Identicon.filter_odd(image) === %Identicon.Image{
      colours: {179, 244, 247},
      hex: [1, 2, 3, 4, 5, 6],
      grid: [{2, 1}, {4, 3}]
    }
  end
end
