defmodule Minishop.Cart do
  import Plug.Conn

  defstruct prod_id: nil, qty: nil
  
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case cart = get_session(conn, :cart) do
      nil ->
        cart = [%Cart{}]
      _ ->
        cart 
    end

    #    cart_id = "100"
    conn = put_session(conn, :cart, cart)
    conn = assign(conn, :cart, cart)
  #  IO.inspect(conn)
     conn
  end

    
end

