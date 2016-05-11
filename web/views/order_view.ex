defmodule Minishop.OrderView do
  use Minishop.Web, :view

  import Ecto.Query
  alias Minishop.Repo
  alias Minishop.Pay_Type

  def display_pay_type(id) do
    Repo.one from p in Pay_Type,
      where: p.id == ^id,
      select: p.description
  end

end
