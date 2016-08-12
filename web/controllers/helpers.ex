defmodule Minishop.Controllers.Helpers do

  import Ecto.Query
  alias Minishop.Product
  alias Minishop.Repo

  def conv_cart(item, dcart) do
    qcart = Repo.one (from p in Product,
        where: p.id == ^item.product_id,
        select: %{prod_id: p.id, sku: p.sku, title: p.title, price: p.price} )

    dcart = List.insert_at(dcart, -1, Map.put_new(qcart, :qty , item.qty) )
  end

end

