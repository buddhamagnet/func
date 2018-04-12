defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  setup_all do
    {:ok, hash: Identicon.hash("decimate")}
  end

  test "create hash" do
    assert Identicon.hash("decimate") == <<179, 244, 247, 32, 65, 113, 252, 85, 250, 49, 86, 40, 108, 199, 135, 17>>
  end

  test "hash to image", state do
    image = Identicon.to_image(state[:hash])
    assert image.hex == [179, 244, 247, 32, 65, 113, 252, 85, 250, 49, 86, 40, 108, 199,135, 17]
  end

  test "pick colour" do
    image = %Identicon.Image{hex: ["red", "green", "blue", "azure"]}
    assert Identicon.pick_colour(image) == ["red", "green", "blue"]
  end

  
end
