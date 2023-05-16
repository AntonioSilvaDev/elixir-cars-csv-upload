defmodule Cars.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :name, :string
      add :model, :string
      add :brand, :string

      timestamps()
    end
  end
end
