defmodule Splurty.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :saying, :string
      add :author, :string
    end
  end
end