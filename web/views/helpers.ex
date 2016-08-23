defmodule Minishop.Views.Helpers do

  alias Monetized.Money
  alias Decimal, as: D

  alias Minishop.Pay_Type
  alias Minishop.Repo
  import Ecto.Query

  def display_pay_type(id) do
    Repo.one from p in Pay_Type,
      where: p.id == ^id,
      select: p.description
  end

  def decimal_to_currency(val) do
#    IO.puts "dtc"
#    IO.inspect val
    # an empty cart causes an error; next line is a quick fix
    # until more investigation
    val = D.to_string(val)
    Money.to_string(Money.make(val, [currency: "USD"]), [currency_symbol: true])
  end
  
  def cart_total(cart) do
    Enum.reduce(cart, D.new(0), fn(item, total) -> 
    total = D.add(total, D.mult(D.new(item.qty), D.new(item.price))) end)
  end
end

