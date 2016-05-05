defmodule Minishop.StoreController do
  use Minishop.Web, :controller
  import Ecto.Query

  plug :put_layout, "store.html"

  alias Minishop.Product
  
  def index(conn, _params) do
    products = Repo.all(Product)

    cart = conn.assigns.cart

    dcart = for i <- cart, into: %{}, do:
    { "title",  Repo.one (from p in Product,
        where: p.id == ^i.prod_id,
        select: p.title) }

      dcart = Enum.reduce(cart, [], &conv_cart/2)
      conn = assign(conn, :dcart, dcart)

    IO.puts("***dcart***")
    IO.inspect(dcart)

    render(conn, "index.html", products: products)
  end

  defp conv_cart(item, dcart) do
    qcart = Repo.one (from p in Product,
        where: p.id == ^item.prod_id,
        select: %{prod_id: p.id, title: p.title, price: p.price} )

    dcart = List.insert_at(dcart, -1, Map.put_new(qcart, :qty , item.qty) )
  end

end

