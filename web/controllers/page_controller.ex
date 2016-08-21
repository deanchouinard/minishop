defmodule Minishop.PageController do
  use Minishop.Web, :controller

  alias Minishop.Product
  alias Minishop.Category
  
  import Ecto.Query

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

  def category_search(conn, %{"id" => category}) do
    sresults = Repo.all from p in Product, where: p.category_id == ^category

    render conn, "search_results.html", sresults: sresults
  end

  def display_product(conn, %{"id" => prod_id}) do
    product = Repo.one from p in Product, where: p.id == ^prod_id

    render conn, "product_display.html", product: product
  end

  def your_cart(conn, _params) do
    cart = conn.assigns.cart
    dcart = build_display_cart(cart)

    render conn, "your_cart.html", dcart: dcart
  end


end
