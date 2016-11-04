defmodule Minishop.Order do
  use Minishop.Web, :model

  schema "orders" do
    has_many :line_items, Minishop.Line_Item
    belongs_to :pay_type, Minishop.Pay_Type
    belongs_to :user, Minishop.User
    belongs_to :ship_address, Minishop.Address

    timestamps
  end

  @required_fields ~w(pay_type_id user_id)
  @optional_fields ~w(ship_address_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:pay_type)
  end
end
