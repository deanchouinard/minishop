defmodule Minishop.Session do
  use Minishop.Web, :model

  schema "sessions" do
    field :key, :string
    field :cart_data, :string

    timestamps
  end

  @required_fields ~w(key)
  @optional_fields ~w(cart_data)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

