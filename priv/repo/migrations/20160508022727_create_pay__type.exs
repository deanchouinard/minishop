defmodule Minishop.Repo.Migrations.CreatePay_Type do
  use Ecto.Migration

  def change do
    create table(:pay_types) do
      add :code, :string, size: 10
      add :description, :string

      timestamps
    end

  end
end
