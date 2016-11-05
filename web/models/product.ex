defmodule Minishop.Product do
  use Minishop.Web, :model

  schema "products" do
    field :sku, :string
    field :title, :string
    field :description, :string
    field :image_url, :string
    field :price, :decimal
    field :category_id, :integer

    timestamps
  end

  @required_fields ~w(sku title)
  @optional_fields ~w(description image_url price category_id)

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
