defmodule Minishop.TestHelpers do
  alias Minishop.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret",
    }, attrs)

    %Minishop.User{}
    |> Minishop.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_line_item(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:line_items, attrs)
    |> Repo.insert!()
  end
end

