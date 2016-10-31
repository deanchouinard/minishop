defmodule Minishop.OrderViewTest do
  use Minishop.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    orders = [%Minishop.Order{id: "1", pay_type_id: "1"},
              %Minishop.Order{id: "2", pay_type_id: "2"}]
    content = render_to_string(Minishop.OrderView, "index.html",
                              conn: conn, orders: orders)

    assert String.contains?(content, "Listing orders")
    for order <- orders do
      assert String.contains?(content, order.pay_type_id)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Minishop.Order.changeset(%Minishop.Order{})
    pay_types = [{"cats", 123}]
    content = render_to_string(Minishop.OrderView, "new.html",
      conn: conn, changeset: changeset, pay_types: pay_types)

    assert String.contains?(content, "New order")
  end
end

