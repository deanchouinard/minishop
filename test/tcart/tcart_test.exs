defmodule TcartTest do
  use ExUnit.Case, async: false

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "cart_server" do
    {:ok, pid} = CartServer.start
    CartServer.add_item(pid, %{date: {2015, 1, 1}, title: "Dinner"})
    CartServer.add_item(pid, %{date: {2015, 1, 2}, title: "Dentist"})
    CartServer.add_item(pid, %{date: {2015, 1, 2}, title: "Movie"})

    assert [%{date: {2015, 1, 1}, id: 1, title: "Dinner"}] ==
      CartServer.items(pid, {2015, 1, 1})

    IO.inspect CartServer.list(pid)
  end

  test "item server" do
    {:ok, pid} = CartServer.start
    CartServer.add_item(pid, %{qty: 1, product_id: 4})
    CartServer.add_item(pid, %{qty: 2, product_id: 5})
    CartServer.add_item(pid, %{qty: 1, product_id: 8})

    assert [%{qty: 1, id: 1, product_id: 4}] ==
      CartServer.line_items(pid, 4)

    IO.inspect CartServer.list(pid)
  end
end

