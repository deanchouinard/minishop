defmodule Minishop.PageView do
  use Minishop.Web, :view
  import Plug.Conn

  def add_pid(conn, pid) do
    conn = assign(conn, :product_id, pid)
  end

end
