defmodule Minishop.OrderView do
  use Minishop.Web, :view

  import Minishop.StoreView, only: [decimal_to_currency: 1]

  import Ecto.Query
  alias Minishop.Repo
  alias Minishop.Pay_Type
  alias Minishop.Product

  def display_pay_type(id) do
    Repo.one from p in Pay_Type,
      where: p.id == ^id,
      select: p.description
  end

  def product_title(prod_id) do
    Repo.one from p in Product,
      where: p.id == ^prod_id,
      select: p.title
  end

  def display_line_items(id) do

  end
end
