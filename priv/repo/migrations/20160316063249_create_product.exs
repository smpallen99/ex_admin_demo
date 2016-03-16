defmodule ExAdminDemo.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :text
      add :author, :string
      add :price, :decimal
      add :featured, :boolean, default: false
      add :available_on, :date
      add :image_file_name, :string

      timestamps
    end

  end
end
