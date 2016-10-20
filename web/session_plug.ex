defmodule Minishop.SessionPlug do
  import Plug.Conn

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

  defp random(number) do
    :rand.uniform(number)
  end
end

