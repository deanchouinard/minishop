defmodule Minishop.PageController do
  use Minishop.Web, :controller

  def index(conn, _params) do
    cart = get_session(conn, :cart)
    render conn, "index.html", cart: cart
  end
end
