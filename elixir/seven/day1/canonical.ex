defmodule Canonical do
  def id(str) do
    :crypto.hash(:sha, str) |> Base.hex_encode32() |> String.downcase()
  end
end
