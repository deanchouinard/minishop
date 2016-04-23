defmodule Minishop.SessionController do
  use Minishop.Web, :controller
  import Plug.Conn

  def add(conn, %{"session" => %{"product" => prod}}) do
    conn = assign(conn, :product, prod)
    conn = put_session(conn, :cart, prod)
    redirect(conn, to: page_path(conn, :index))

  end
end

