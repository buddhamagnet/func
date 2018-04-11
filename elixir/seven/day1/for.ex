# For comprehensions

print = fn x -> IO.puts(x) end

for x <- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], do: print.(x)

IO.inspect(
  for x <- [1, 2],
      y <- [3, 4],
      z <- [5],
      do: {x, y, z}
)

IO.inspect(
  for a <- [1, 2],
      b <- [3, 4],
      c <- [5],
      a + b < 5,
      do: {a, b, c}
)

defmodule Quicksort do
  def sort([]), do: []

  def sort([head | tail]) do
    sort(for(x <- tail, x <= head, do: x)) ++ [head] ++ sort(for(x <- tail, x > head, do: x))
  end
end

IO.inspect(Quicksort.sort([5, 6, 3, 2, 7, 8]))
