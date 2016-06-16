defmodule Minishop.PageController do
  use Minishop.Web, :controller

  def index(conn, _params) do
    #IO.inspect conn
    cart = conn.assigns.cart
    # cart = get_session(conn, :cart)
    render conn, "index.html", cart: cart
  end
end
