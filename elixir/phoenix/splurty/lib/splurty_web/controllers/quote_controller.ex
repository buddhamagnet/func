defmodule SplurtyWeb.QuoteController do
  use SplurtyWeb, :controller

  def index(conn, _params) do
    quotes = Splurty.Repo.all(SplurtyWeb.Quote)
    render conn, "index.html", quotes: quotes
  end
end