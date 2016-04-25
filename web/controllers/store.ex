defmodule Minishop.StoreController do
  use Minishop.Web, :controller

  alias Minishop.Product
  
  def index(conn, _params) do
    products = Repo.all(Product)
    render(conn, "index.html", products: products)
  end
end

