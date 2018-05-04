defmodule RPG do
  def points(%{str: str, dex: dex, int: int}) do
    str * 2 + dex * 3 + int * 3
  end
end
