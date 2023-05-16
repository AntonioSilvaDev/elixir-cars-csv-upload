defmodule Cars.Auto.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    field :brand, :string
    field :model, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:name, :model, :brand])
    |> validate_required([:name, :model, :brand])
  end
end
