defmodule Minishop.StoreView do
  use Minishop.Web, :view

#  use  Monitized.Money

  alias Monetized.Money

  def decimal_to_currency(val) do
    Money.to_string(Money.make(val, [currency: "USD"]), [currency_symbol: true])
  end

end
