defmodule TcartTest do
  use ExUnit.Case, async: false

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "cart_server" do
    {:ok, cache} = Tcart.Cache.start
    ref = Tcart.Cache.server_process(cache, "AAA")
    Tcart.Server.add_item(ref, %{date: {2015, 1, 1}, title: "Dinner"})
    Tcart.Server.add_item(ref, %{date: {2015, 1, 2}, title: "Dentist"})
    Tcart.Server.add_item(ref, %{date: {2015, 1, 2}, title: "Movie"})

    assert [%{date: {2015, 1, 1}, id: 1, title: "Dinner"}] ==
      Tcart.Server.items(ref, {2015, 1, 1})

    IO.inspect Tcart.Server.list(ref)
  end

  test "item server" do
    {:ok, cache} = Tcart.Cache.start
    ref = Tcart.Cache.server_process(cache, "AAAB")
    Tcart.Server.add_item(ref, %{qty: 1, product_id: 4})
    Tcart.Server.add_item(ref, %{qty: 2, product_id: 5})
    Tcart.Server.add_item(ref, %{qty: 1, product_id: 8})

    assert [%{qty: 1, id: 1, product_id: 4}] ==
      Tcart.Server.line_items(ref, 4)

    IO.inspect Tcart.Server.list(ref)
  end
end

