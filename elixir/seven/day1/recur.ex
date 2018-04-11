defmodule Recur do
  def print([]), do: :ok

  def print([head | tail]) do
    IO.puts(head)
    print(tail)
  end

  def enum(x) do
    Enum.each(x, &IO.puts(&1))
  end

  def filter(x, num) do
    Enum.filter(x, &(&1 > num))
  end

  def filter_fives(x) do
    Recur.filter(x, 5)
  end

  def sum(x) do
    Enum.reduce(x, &(&1 + &2))
  end

  def any(x, num) do
    Enum.any?(x, &(&1 > num))
  end
end

list = [:mouth, :on, :a, :stick]
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

IO.puts("--using our own recursive function--")
Recur.print(list)
IO.puts("--using Enum--")
Recur.enum(list)
IO.puts("--filtering greater than 5")
IO.inspect(Recur.filter(nums, 5))
IO.inspect(Recur.filter_fives(nums))
IO.puts("--sum function--")
IO.inspect(Recur.sum(nums))
IO.puts("--any function--")
IO.inspect(Recur.any(nums, 100))
