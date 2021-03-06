defmodule Minishop.Line_Item do
  use Minishop.Web, :model

  schema "line_items" do
    field :quantity, :integer
    field :total_price, :decimal
    belongs_to :product, Minishop.Product
    belongs_to :order, Minishop.Order

    timestamps
  end

  @required_fields ~w(quantity total_price)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
