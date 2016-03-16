defmodule ExAdminDemo.Repo.Migrations.CreateLineItem do
  use Ecto.Migration

  def change do
    create table(:line_items) do
      add :price, :decimal
      add :order_id, references(:orders, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps
    end
    create index(:line_items, [:order_id])
    create index(:line_items, [:product_id])

  end
end
