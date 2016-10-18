defmodule Minishop.Router do
  use Minishop.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Minishop.SessionPlug, repo: Minishop.Repo
    plug Minishop.Auth, repo: Minishop.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Minishop do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/category_search/:id", PageController, :category_search
    get "/display_product/:id", PageController, :display_product
    get "/your_cart", PageController, :your_cart
    get "/checkout", PageController, :checkout

    #    post "/", SessionController, :add
    get "/session/clear", SessionController, :clear
    #    get "/session/add_cart/:title", SessionController, :add_to_cart
    get "/cart/add_cart/:id", CartController, :add_to_cart

    get "/store", StoreController, :index
    get "/store/checkout", StoreController, :checkout
    get "/orders/new", OrderController, :new
    get "/orders/show/:id", OrderController, :show
    post "/orders/create", OrderController, :create

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

  end

  scope "/manage", Minishop do
    pipe_through [:browser, :authenticate_user]

    resources "/products", ProductController
#    resources "/orders", OrderController
    resources "/line_items", Line_ItemController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Minishop do
  #   pipe_through :api
  # end
end
