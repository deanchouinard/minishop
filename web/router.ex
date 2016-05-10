defmodule Minishop.Router do
  use Minishop.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Minishop.Cart, repo: Minishop.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Minishop do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", SessionController, :add
    get "/session/clear", SessionController, :clear
    #    get "/session/add_cart/:title", SessionController, :add_to_cart
    get "/session/add_cart/:id", SessionController, :add_to_cart

    get "/store", StoreController, :index
    get "/store/checkout", StoreController, :checkout
    get "/orders/new", OrderController, :new
    post "/orders/create", OrderController, :create

  end

  scope "/manage", Minishop do
    pipe_through :browser

    resources "/products", ProductController
#    resources "/orders", OrderController
    resources "/line_items", Line_ItemController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Minishop do
  #   pipe_through :api
  # end
end
