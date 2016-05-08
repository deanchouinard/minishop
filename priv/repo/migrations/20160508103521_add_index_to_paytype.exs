defmodule Minishop.Repo.Migrations.AddIndexToPaytype do
  use Ecto.Migration

  def change do
    alter table(:pay_types) do
      modify :code, :string, size: 10, null: false
    end

    create unique_index(:pay_types, [:code])
  end
end
