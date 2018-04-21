defmodule SplurtyWeb.Router do
  use SplurtyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SplurtyWeb do
    pipe_through :browser

    resources "/quotes", QuoteController

  end

  # Other scopes may use custom stacks.
  # scope "/api", SplurtyWeb do
  #   pipe_through :api
  # end
end
