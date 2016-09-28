defmodule Minishop.Cart do
#  @on_load :reseed_generator
  import Plug.Conn
  
  # defmodule Item do
  #   defstruct prod_id: nil, qty: nil
  # end
  

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    cart_key = conn.cookies["cart_key"]
    {conn, cart_key} = case cart_key do
      nil -> token = to_string(random(100000))
        IO.puts "rtoken #{token}"
        cart_key = Phoenix.Token.sign(conn, "cart_key", token)
        conn = Plug.Conn.put_resp_cookie(conn, "cart_key", cart_key)
        {conn, cart_key}
      _ -> {conn, cart_key}
    end

    {:ok, cart_key} = Phoenix.Token.verify(conn, "cart_key", cart_key)
    conn = assign(conn, :cart_key, cart_key)
    cart_pid = Tcart.Cache.server_process(cart_key)
    cart = Tcart.Server.list(cart_pid)
    conn = assign(conn, :cart_pid, cart_pid)
    conn = assign(conn, :cart, cart)
    conn
  end

  # this random number generator is horrible; need to
  # come up with a better plan
  def random(number) do
  #    reseed_generator()
    :rand.uniform(number)
  end
    
  def reseed_generator do
    # :random.seed(:os.timestamp())
    :rand.seed(:erlang.phash2([:erlang.node()]),
                :erlang.monotonic_time(),
                :erlang.unique_integer())
    :ok
  end

end

