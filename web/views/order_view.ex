defmodule Minishop.OrderView do
  use Minishop.Web, :view

#  import Minishop.StoreView, only: [decimal_to_currency: 1]

  import Ecto.Query
  alias Minishop.Repo
  alias Minishop.Product
  alias Minishop.User

  def username(user_id) do
    Repo.one from u in User,
      where: u.id == ^user_id,
      select: u.username
  end

  def product_title(prod_id) do
    Repo.one from p in Product,
      where: p.id == ^prod_id,
      select: p.title
  end

  def display_line_items(id) do

  end
end
