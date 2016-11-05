defmodule Minishop.Address do
  use Minishop.Web, :model

  schema "addresses" do
    field :address1, :string
    field :address2, :string
    field :city, :string
    field :state, :string
    field :zipcode, :string
    field :phone, :string

    belongs_to :user, Minishop.User

    timestamps
  end

  @required_fields ~w(address1 city state zipcode user_id)
  @optional_fields ~w(address2 phone)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:state, is: 2)
    |> validate_format(:zipcode, ~r/[0-9]+/)
    |> validate_length(:zipcode, max: 9)
    |> validate_format(:phone, ~r/[0-9]+/)
    |> validate_length(:phone, max: 10)
  end
end
