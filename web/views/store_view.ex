defmodule Minishop.StoreView do
  use Minishop.Web, :view

#  use  Monitized.Money

  alias Monetized.Money
  alias Decimal, as: D

  def decimal_to_currency(val) do
    Money.to_string(Money.make(val, [currency: "USD"]), [currency_symbol: true])
  end

  def cart_total(cart) do
    Enum.reduce(cart, D.new(0), fn(item, total) -> 
    total = D.add(total, D.mult(D.new(item.qty), D.new(item.price))) end)
  end
end
