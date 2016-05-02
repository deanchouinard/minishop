defmodule Minishop.StoreController do
  use Minishop.Web, :controller

  plug :put_layout, "store.html"

  alias Minishop.Product
  
  def index(conn, _params) do
    products = Repo.all(Product)

    cart = conn.assigns.cart

    render(conn, "index.html", products: products)
  end
end

