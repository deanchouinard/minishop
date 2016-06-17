defmodule Minishop.SessionController do
  use Minishop.Web, :controller
  import Plug.Conn

  def add(conn, %{"session" => %{"product" => prod}}) do
    cart = get_session(conn, :cart) || []
    # conn = assign(conn, :product, prod)
    IO.inspect(cart)
    cart = List.insert_at(cart, -1, prod)
    conn = put_session(conn, :cart, cart)
    redirect(conn, to: page_path(conn, :index))

  end

  def add_to_cart(conn, %{"id" => prod}) do
    prod = %{qty: 1, product_id: String.to_integer(prod)}
    IO.inspect(prod)
    conn = add_prod_to_cart(conn, prod)
    redirect(conn, to: store_path(conn, :index))
  end

  def clear(conn, _params) do
    conn = Plug.Conn.configure_session(conn, drop: true)
    redirect(conn, to: page_path(conn, :index))
  end

  defp add_prod_to_cart(conn, prod) do
#    prod = %{prod_id: 9, qty: 1}
    cart_pid = conn.assigns.cart_pid

    IO.puts "add prod to cart"
#     IO.inspect cart_key
    IO.inspect prod

    case item = Tcart.Server.line_items(cart_pid, prod.product_id) do
      nil -> Tcart.Server.add_item(cart_pid, prod)

      _ ->
    end

    cart = Tcart.Server.list(cart_pid)

    # case index = Enum.find_index(cart, fn(x) -> x.prod_id == prod.prod_id end) do
    #   nil -> cart = List.insert_at(cart, -1, prod)
    #
    #   _ -> cart = update_cart(cart, prod, index)
    # end

#    cart = get_session(conn, :cart) || []
    # conn = assign(conn, :product, prod)
    IO.inspect(cart)
    # conn = put_session(conn, :cart, cart)
    conn = assign(conn, :cart, cart)
  end

  defp update_cart(cart, prod, index) do

    item = Enum.fetch!(cart, index)
    item = Map.update!(item, :qty, &(&1 + prod.qty))
    cart = List.replace_at(cart, index, item)
  end

end

