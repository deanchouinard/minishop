defmodule Minishop.PageController do
  use Minishop.Web, :controller

  alias Minishop.Product

  def index(conn, _params) do
    products = Repo.all(Product)
    #IO.inspect conn
    cart = conn.assigns.cart
    # cart = get_session(conn, :cart)
    render conn, "index.html", [ cart: cart, products: products ]
  end
end
