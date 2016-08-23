defmodule Minishop.Controllers.Helpers do

  import Ecto.Query
  alias Minishop.Product
  alias Minishop.Repo
  alias Minishop.Pay_Type

  def build_display_cart(cart), do: Enum.reduce(cart, [], &conv_cart/2)
  
  defp conv_cart(item, dcart) do
    qcart = Repo.one (from p in Product,
        where: p.id == ^item.product_id,
        select: %{prod_id: p.id, sku: p.sku, 
          title: p.title, price: p.price} )

    dcart = List.insert_at(dcart, -1, Map.put_new(qcart, :qty , item.qty) )
  end

  def load_pay_types(conn, _) do
    query =
      Pay_Type
      |> Pay_Type.alphabetical
      |> Pay_Type.code_and_ids
    pay_types = Repo.all query
    Plug.Conn.assign(conn, :pay_types, pay_types)
  end

end

