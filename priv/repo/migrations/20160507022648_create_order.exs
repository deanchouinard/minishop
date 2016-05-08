defmodule Minishop.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :name, :string
      add :address, :text
      add :email, :string
      add :pay_type, :string, size: 10

      timestamps
    end

  end
end
