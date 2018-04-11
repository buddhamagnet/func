inc = fn x -> x + 1 end

IO.puts("calling simple increment")
IO.puts(inc.(1))
IO.puts(inc.(2))

double_call = fn x, f -> f.(f.(x)) end

IO.puts("calling double_call")
IO.puts(double_call.(2, inc))

add = &(&1 + &2)

IO.puts("calling add")
IO.puts(add.(1, 2))

IO.puts("calling inc (partial application)")
inc = &add.(&1, 1)
IO.puts(inc.(1))
IO.puts("calling dec (partial application)")
dec = &add.(&1, -1)
IO.puts(dec.(1))

IO.puts("calling inc twice then dec with pipes")

IO.puts(10 |> inc.() |> inc.() |> dec.())

defmodule Sugar do
  def mode(x \\ "decimate"), do: x

  def options(code, options \\ []) do
    IO.puts(code)
    IO.inspect(options)
  end
end

IO.puts(Sugar.mode())
IO.puts(Sugar.mode("good"))

Sugar.options(100, color: "red", name: "@buddhamagnet")
