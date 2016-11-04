defmodule Minishop.TestHelpers do
  alias Minishop.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret",
      email: "test@test.com",
    }, attrs)

    %Minishop.User{}
    |> Minishop.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_order(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:orders, attrs)
    |> Repo.insert!()
  end
end

