defmodule Cars.AutoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cars.Auto` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        model: "some model",
        name: "some name"
      })
      |> Cars.Auto.create_car()

    car
  end
end
