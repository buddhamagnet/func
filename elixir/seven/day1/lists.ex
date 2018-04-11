list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
IO.puts(inspect(list))
IO.puts("is a list a list?")
IO.puts(is_list(list))
IO.puts("is a tuple a list")
IO.puts(is_list({:mouth, :on, :a, :stick}))
IO.puts("is a list a tuple?")
IO.puts(is_tuple(list))
IO.puts("is a char list a list?")
IO.puts(is_list('dave'))
IO.puts("is a string a list?")
IO.puts(is_list("dave"))
IO.puts("is a map a list?")
IO.puts(is_list(%{one: 1, two: 2}))

IO.puts("Now some list assembly")
IO.inspect([0 | list])
IO.inspect([0 | []])
IO.inspect([[4, 5, 6] | list])
IO.inspect([-2, -1, 0 | list])

IO.puts("And some pattern matching")
mutants = [:wolverine, :magneto, :cyclops]
IO.inspect([x, y, z] = mutants)
IO.inspect({x, y, z})
[wolf, magnet, _] = mutants
IO.puts(wolf)
IO.puts(magnet)

IO.puts("And now using |, construction in reverse")
[head | tail] = mutants
IO.puts(inspect({head, tail}))
[one, two | tail] = mutants
IO.puts(inspect({one, two, tail}))
