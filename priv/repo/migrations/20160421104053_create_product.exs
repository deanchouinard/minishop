defmodule Minishop.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :text
      add :image_url, :string
      add :price, :decimal, precision: 8, scale: 2, default: 0

      timestamps
    end

  end
end
