defmodule Minishop.PageView do
  use Minishop.Web, :view
  
  alias Monetized.Money
  alias Decimal, as: D

  def decimal_to_currency(val) do
#    IO.puts "dtc"
#    IO.inspect val
    # an empty cart causes an error; next line is a quick fix
    # until more investigation
    val = D.to_string(val)
    Money.to_string(Money.make(val, [currency: "USD"]), [currency_symbol: true])
  end
end
