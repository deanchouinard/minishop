defmodule Minishop.Repo.Migrations.AddPaytypeIdToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      remove :pay_type

      add :pay_type_id, references(:pay_types)
    end
  end
end
