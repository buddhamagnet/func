defmodule SplurtyWeb.Quote do
  use SplurtyWeb, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string
  end
end