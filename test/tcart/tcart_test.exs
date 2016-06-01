defmodule TcartTest do
  use ExUnit.Case, async: false

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "cart_server" do
    {:ok, pid} = Minishop.Server.start
    Minishop.Server.add_item(pid, %{date: {2015, 1, 1}, title: "Dinner"})
    Minishop.Server.add_item(pid, %{date: {2015, 1, 2}, title: "Dentist"})
    Minishop.Server.add_item(pid, %{date: {2015, 1, 2}, title: "Movie"})

    assert [%{date: {2015, 1, 1}, id: 1, title: "Dinner"}] ==
      Minishop.Server.items(pid, {2015, 1, 1})

    IO.inspect Minishop.Server.list(pid)
  end

  test "item server" do
    {:ok, pid} = Minishop.Server.start
    Minishop.Server.add_item(pid, %{qty: 1, product_id: 4})
    Minishop.Server.add_item(pid, %{qty: 2, product_id: 5})
    Minishop.Server.add_item(pid, %{qty: 1, product_id: 8})

    assert [%{qty: 1, id: 1, product_id: 4}] ==
      Minishop.Server.line_items(pid, 4)

    IO.inspect Minishop.Server.list(pid)
  end
end

