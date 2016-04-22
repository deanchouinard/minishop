defmodule Minishop.Cart do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case cart_id = get_session(conn, :cart_id) do
      nil ->
        cart_id = "101"
      _ ->
        cart_id
    end

    #    cart_id = "100"
    conn = put_session(conn, :cart_id, cart_id)
    conn = assign(conn, :cart, cart_id)
    # IO.inspect(conn)
    # conn
  end
end

