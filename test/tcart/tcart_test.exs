defmodule TcartTest do
  use ExUnit.Case, async: false

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "cart_server" do
    {:ok, pid} = Tcart.Server.start
    Tcart.Server.add_item(pid, %{date: {2015, 1, 1}, title: "Dinner"})
    Tcart.Server.add_item(pid, %{date: {2015, 1, 2}, title: "Dentist"})
    Tcart.Server.add_item(pid, %{date: {2015, 1, 2}, title: "Movie"})

    assert [%{date: {2015, 1, 1}, id: 1, title: "Dinner"}] ==
      Tcart.Server.items(pid, {2015, 1, 1})

    IO.inspect Tcart.Server.list(pid)
  end

  test "item server" do
    {:ok, pid} = Tcart.Server.start
    Tcart.Server.add_item(pid, %{qty: 1, product_id: 4})
    Tcart.Server.add_item(pid, %{qty: 2, product_id: 5})
    Tcart.Server.add_item(pid, %{qty: 1, product_id: 8})

    assert [%{qty: 1, id: 1, product_id: 4}] ==
      Tcart.Server.line_items(pid, 4)

    IO.inspect Tcart.Server.list(pid)
  end
end

