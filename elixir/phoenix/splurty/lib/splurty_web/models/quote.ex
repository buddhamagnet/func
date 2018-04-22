defmodule SplurtyWeb.Quote do
  use SplurtyWeb, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:saying, :author])
    |> validate_required([:saying, :author])
  end
end