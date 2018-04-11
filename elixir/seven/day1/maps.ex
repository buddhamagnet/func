badass = %{name: "dave", age: 50}

IO.puts("basic map")
IO.inspect(badass)
IO.inspect(badass[:name])
IO.inspect(badass.age)

# Shortcut syntax - new map with one element changed.
IO.puts("using put_in")
badass = %{name: "dave", creds: %{age: 50, sex: "male"}}
IO.inspect(put_in(badass.creds.age, 21))

# Full destructuring.
%{name: name, creds: %{age: age}} = badass
IO.puts(name)
IO.puts(age)
