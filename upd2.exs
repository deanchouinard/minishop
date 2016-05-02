#
# Update a list of Maps using recursion
#

defmodule Upd do

  def update_prod([], _key, _val), do: []
  def update_prod([ %{prod_id: prod_id, qty: qty} = _head | tail ] = _cart, key, val) 
    when prod_id == key do
      IO.puts "update wprod"
#       qty = qty + val
      [ %{prod_id: prod_id, qty: qty + val} | update_prod(tail, key, val) ]
  end
#  def update_prod([ %{prod_id: prod_id, qty: qty} = head | tail ] = cart, key, val) do
  def update_prod([ head | tail ] = _cart, key, val) do
    IO.puts "update prod"
    [ head | update_prod(tail, key, val) ]
  end
end

cart = []

prod = %{prod_id: 9, qty: 1}

cart = List.insert_at(cart, -1, prod)

prod = %{prod_id: 7, qty: 1}
cart = List.insert_at(cart, -1, prod)
prod = %{prod_id: 8, qty: 1}
cart = List.insert_at(cart, -1, prod)
prod = %{prod_id: 9, qty: 1}

cart = Upd.update_prod(cart, prod.prod_id, prod.qty)

prod = %{prod_id: 6, qty: 1}
cart = Upd.update_prod(cart, prod.prod_id, prod.qty)
#cart = List.insert_at(cart, -1, prod)
# case Upd.prod_exists(cart, prod) do
#   cart -> cart
#
#   _ -> cart = List.insert_at(cart, -1, prod)
# end
#
IO.inspect(cart)


