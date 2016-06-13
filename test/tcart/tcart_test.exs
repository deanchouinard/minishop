defmodule TcartTest do
  use Minishop.ConnCase
  use ExUnit.Case, async: false

  test "empty cart" do
    assert(0 == Tcart.Cart.size(Tcart.Cart.new))
  end

  test "cart_server" do
    ref = Tcart.Cache.server_process("AAA")
    Tcart.Server.add_item(ref, %{date: {2015, 1, 1}, title: "Dinner"})
    Tcart.Server.add_item(ref, %{date: {2015, 1, 2}, title: "Dentist"})
    Tcart.Server.add_item(ref, %{date: {2015, 1, 2}, title: "Movie"})

    assert [%{date: {2015, 1, 1}, id: 1, title: "Dinner"}] ==
      Tcart.Server.items(ref, {2015, 1, 1})

      #    IO.inspect Tcart.Server.list(ref)
  end

  test "item server" do
    ref = Tcart.Cache.server_process("AAAB")
    Tcart.Server.add_item(ref, %{qty: 1, product_id: 4})
    Tcart.Server.add_item(ref, %{qty: 2, product_id: 5})
    Tcart.Server.add_item(ref, %{qty: 1, product_id: 8})

    assert [%{qty: 1, id: 1, product_id: 4}] ==
      Tcart.Server.line_items(ref, 4)

      #    IO.inspect Tcart.Server.list(ref)
  end

  test "item server database" do
    ref2 = Tcart.Cache.server_process("AAAB")
    
    IO.inspect Tcart.Server.list(ref2)
    assert [%{qty: 1, id: 1, product_id: 4}] ==
      Tcart.Server.line_items(ref2, 4)
  end

end

