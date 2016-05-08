defmodule Minishop.Repo.Migrations.CreateLine_Item do
  use Ecto.Migration

  def change do
    create table(:line_items) do
      add :quantity, :integer
      add :total_price, :decimal, precision: 15, scale: 2
      add :product_id, references(:products, on_delete: :nothing)
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps
    end
    create index(:line_items, [:product_id])
    create index(:line_items, [:order_id])

  end
end
