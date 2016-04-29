defmodule Minishop.Cart do
  import Plug.Conn
  
  defmodule Item do
    defstruct prod_id: nil, qty: nil
  end
  
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case cart = get_session(conn, :cart) do
      nil ->
        cart = [%Item{}]
      _ ->
        cart
    end

    #    cart_id = "100"
#    conn = put_session(conn, :cart, cart)
    conn = assign(conn, :cart, cart)
  #  IO.inspect(conn)
     conn
  end

    
end

