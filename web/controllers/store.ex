defmodule Minishop.StoreController do
  use Minishop.Web, :controller
  import Ecto.Query

  plug :put_layout, "store.html"

  alias Minishop.Product
  
  def index(conn, _params) do
    products = Repo.all(Product)

    cart = conn.assigns.cart

    dcart = for i <- cart, into: %{}, do:
    { Repo.one (from p in Product,
        where: p.id == ^i.prod_id,
        select: p.title) }

    IO.puts("***dcart***")
    IO.inspect(dcart)

    render(conn, "index.html", products: products)
  end
end

