defmodule Upd do
  def prod_exists(cart, prod) do
    IO.puts "prod exixts"
    Enum.map(cart, fn({prod_id, qty} = x) -> if x.prod_id ==
    prod.prod_id, do: IO.inspect( x) end)
  end

  def update_prod(cart, prod, updater_fun) do
    IO.puts "update prod"
    case prod_exists(cart, prod) do
      nil -> cart

      old_item ->
        IO.puts "old item"
        new_item = updater_fun.(old_item)
        new_cart = Map.put(cart, new_item.prod_id, new_item)
    end
  end
end

cart = []

prod = %{prod_id: 9, qty: 1}

cart = List.insert_at(cart, -1, prod)

prod = %{prod_id: 8, qty: 1}
cart = List.insert_at(cart, -1, prod)
prod = %{prod_id: 9, qty: 1}

cart = Upd.update_prod(cart, prod.prod_id, &Map.put(&1, :qty, 7))

# case Upd.prod_exists(cart, prod) do
#   cart -> cart
#
#   _ -> cart = List.insert_at(cart, -1, prod)
# end
#
IO.inspect(cart)


