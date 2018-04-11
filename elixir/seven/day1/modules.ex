defmodule Rectangle do
  def area({h, w}), do: h * w

  def perimeter({h, w}) do
    2 * (h + w)
  end
end

IO.puts("calling Rectangle.area on 10, 10")
IO.puts(Rectangle.area({10, 10}))

IO.puts("calling Rectangle.permiter on 10, 10")
IO.puts(Rectangle.perimeter({10, 10}))

defmodule Square do
  def area({w}), do: Rectangle.area({w, w})

  def area({w, h}) when w == h do
    Rectangle.area({w, w})
  end

  def perimeter({w}) do
    Rectangle.perimeter({w, w})
  end

  def perimeter({w, h}) when w == h do
    Rectangle.perimeter({w, w})
  end
end
