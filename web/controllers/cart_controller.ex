defmodule Minishop.CartController do
  use Minishop.Web, :controller
  require Logger

  def add_item(conn, %{"add_item" => %{"qty" => qt2, "id" => prod_id}}) do
    # %{"qty" => qt2} = qty
    IO.inspect qt2
    IO.inspect prod_id
    IO.inspect conn.assigns
    redirect(conn, to: page_path(conn, :index))
  end

  def add_to_cart(conn, %{"id" => prod_id}) do
    prod = %{qty: 1, product_id: String.to_integer(prod_id)}
    IO.inspect(prod)
    conn = add_prod_to_cart(conn, prod)
    redirect(conn, to: page_path(conn, :index))
  end
  
  defp add_prod_to_cart(conn, prod) do
#    prod = %{prod_id: 9, qty: 1}
    cart_pid = conn.assigns.cart_pid

    IO.puts "add prod to cart"
#     IO.inspect cart_key
    Logger.info fn -> inspect prod end

    case item = Tcart.Server.line_items(cart_pid, prod.product_id) do
      [] -> Tcart.Server.add_item(cart_pid, prod)

      _ -> IO.puts "item:"
      IO.inspect Enum.at(item, 0).qty
      up_qty = Enum.at(item, 0).qty + prod.qty
      Tcart.Server.update_item(cart_pid, Enum.at(item, 0).id, &Map.put(&1, :qty, up_qty))
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
    _conn = assign(conn, :cart, cart)
  end
end

