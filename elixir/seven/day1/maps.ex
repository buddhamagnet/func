badass = %{name: "dave", age: 50}

IO.puts("basic map")
IO.inspect(badass)
IO.inspect(badass[:name])
IO.inspect(badass.age)

# New maps with changes
IO.puts("using Map.put and some nice syntax")
colours = %{primary: "blue"}
IO.inspect(Map.put(colours, :primary, "red"))
IO.inspect(%{colours | primary: "azure"})

# Shortcut syntax - new map with one element changed.
IO.puts("using put_in")
badass = %{name: "dave", creds: %{age: 50, sex: "male"}}
IO.inspect(put_in(badass.creds.age, 21))

# Full destructuring.
%{name: name, creds: %{age: age}} = badass
IO.puts(name)
IO.puts(age)
