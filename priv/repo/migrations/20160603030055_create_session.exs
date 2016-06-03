defmodule Minishop.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :key, :string, null: false
      add :cart_data, :text

      timestamps
    end

    create unique_index(:sessions, [:key])
  end
end
