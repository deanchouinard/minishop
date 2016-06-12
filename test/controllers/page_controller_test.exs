defmodule Minishop.PageControllerTest do
  use Minishop.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Minishop"
  end
end
