defmodule Minishop.User do
  use Minishop.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :orders, Minishop.Order
    has_many :addresses, Minishop.Address

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name username email), [])
    |> validate_length(:username, min: 1, max: 20)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username, name: :username_index)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end


end

