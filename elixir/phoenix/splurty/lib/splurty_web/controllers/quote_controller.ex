defmodule SplurtyWeb.QuoteController do
  use SplurtyWeb, :controller

  alias SplurtyWeb.Quote
  alias Splurty.Repo

  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render conn, "index.html", quotes: quotes
  end

  def new(conn, params) do
    changeset = Quote.changeset(%Quote{}, %{})
    render conn, "new.html", changeset: changeset
  end

   def create(conn, %{"quote" => quote}) do
    changeset = Quote.changeset(%Quote{}, quote)
    case Repo.insert(changeset) do
      {:ok, quote} ->
        render conn, "index.html"
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end