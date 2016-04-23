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

  def clear(conn, _params) do
    conn = Plug.Conn.configure_session(conn, drop: true)
    redirect(conn, to: page_path(conn, :index))
  end

end

