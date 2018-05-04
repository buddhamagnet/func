defmodule Tax do
  def calc(salary) when salary <= 2000, do: 0
  def calc(salary) when salary <= 3000, do: salary * 0.05
  def calc(salary) when salary <= 6000, do: salary * 0.1
  def calc(salary), do: salary * 0.15

  # book solution didn't even use a funcion
  # and used multiple IO.puts statements, here
  # we assign the result of the case to a variable
  # and just output that.
  def putTax do
    salary = IO.gets("enter your salary: ")

    result =
      case Float.parse(salary) do
        :error ->
          "invalid number"

        {salary, _} ->
          tax = calc(salary)
          "your tax is #{tax}"
      end

    IO.puts(result)
  end
end
