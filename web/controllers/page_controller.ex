defmodule Minishop.PageController do
  use Minishop.Web, :controller

  alias Minishop.Product
  alias Minishop.Category
  
  def index(conn, _params) do
    products = Repo.all(Product)
    categories = Repo.all(Category)
    #IO.inspect conn
    cart = conn.assigns.cart
    dcart = build_display_cart(cart)
    # conn = assign(conn, :dcart, dcart)
    # cart = get_session(conn, :cart)
    render conn, "index.html", [ dcart: dcart, products: products,
                                categories: categories ]
  end
end
