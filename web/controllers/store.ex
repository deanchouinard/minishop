defmodule Minishop.StoreController do
  use Minishop.Web, :controller
  import Ecto.Query

  plug :put_layout, "store.html"

  alias Minishop.Product
  alias Minishop.Order
  
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

  def checkout(conn, params) do

  #    IO.puts "****checkout"
  #  IO.inspect(params)
    IO.inspect(conn.assigns)

    cart = conn.assigns.cart
    dcart = Enum.reduce(cart, [], &conv_cart/2)

    changeset = Order.changeset(%Order{})
    render conn, Minishop.OrderView, "new.html", changeset: changeset,
      action: order_path(conn, :create), dcart: dcart

    # render conn, "checkout.html", changeset: changeset,
    #   action: order_path(conn, :create), dcart: dcart

    # conn
    # |> put_flash(:info, "checkout clicked")
    # |> redirect(to: store_path(conn, :index))
  end

  defp conv_cart(item, dcart) do
    qcart = Repo.one (from p in Product,
        where: p.id == ^item.prod_id,
        select: %{prod_id: p.id, title: p.title, price: p.price} )

    dcart = List.insert_at(dcart, -1, Map.put_new(qcart, :qty , item.qty) )
  end

end

