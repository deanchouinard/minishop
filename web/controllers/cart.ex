defmodule Minishop.Cart do
  import Plug.Conn
  
  defmodule Item do
    defstruct prod_id: nil, qty: nil
  end
  
  @on_load :reseed_generator

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case cart = get_session(conn, :cart) do
      nil ->
        cart = []
        # cart = [%{prod_id: 12}]
#        cart = [%Minishop.Cart.Item{}]
      _ ->
        cart
    end

    #    cart_id = "100"
    conn = put_session(conn, :cart, cart)
    conn = assign(conn, :cart, cart)
    #  IO.inspect(conn)
    IO.inspect(cart)

    skey = get_session(conn, :cookies)
    IO.puts "skey"
    IO.inspect skey
    IO.puts "cookies"
    IO.inspect(conn.cookies["_minishop_key"])
    IO.inspect(conn)

    case cart_key = conn.cookies["cart_key"] do
      nil -> token = random(10)
            token = Phoenix.Token.sign
    conn
  end

  def random(number) do
    :random.uniform(number)
  end
    
  def reseed_generator do
    :random.seed(:erlang.now())
  end

end

