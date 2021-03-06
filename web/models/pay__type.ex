defmodule Minishop.Pay_Type do
  use Minishop.Web, :model

  schema "pay_types" do
    field :code, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(code description)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def alphabetical(query) do
    from p in query, order_by: p.code
  end

  def code_and_ids(query) do
    from p in query, select: {p.code, p.id}
  end

end
