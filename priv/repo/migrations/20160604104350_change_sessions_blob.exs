defmodule Minishop.Repo.Migrations.ChangeSessionsBlob do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      remove :cart_data
      add :cart_data, :bytea
    end
  end
end
