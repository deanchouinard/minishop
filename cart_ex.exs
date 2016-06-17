
    ref = Tcart.Cache.server_process("AAAB")
    Tcart.Server.add_item(ref, %{qty: 1, product_id: 4})
    Tcart.Server.add_item(ref, %{qty: 2, product_id: 5})
    Tcart.Server.add_item(ref, %{qty: 1, product_id: 8})

    IO.inspect Tcart.Server.list(ref)
    
    #assert [%{qty: 1, id: 1, product_id: 4}] ==
    lir = Tcart.Server.line_items(ref, 4)

    IO.inspect lir

    :timer.sleep(500)
    Ecto.Adapters.SQL.query(Minishop.Repo, "delete from sessions where
    key = $1", ["AAAB"])

