defmodule Cars.AutoTest do
  use Cars.DataCase

  alias Cars.Auto

  describe "cars" do
    alias Cars.Auto.Car

    import Cars.AutoFixtures

    @invalid_attrs %{brand: nil, model: nil, name: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Auto.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Auto.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{brand: "some brand", model: "some model", name: "some name"}

      assert {:ok, %Car{} = car} = Auto.create_car(valid_attrs)
      assert car.brand == "some brand"
      assert car.model == "some model"
      assert car.name == "some name"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auto.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()

      update_attrs = %{
        brand: "some updated brand",
        model: "some updated model",
        name: "some updated name"
      }

      assert {:ok, %Car{} = car} = Auto.update_car(car, update_attrs)
      assert car.brand == "some updated brand"
      assert car.model == "some updated model"
      assert car.name == "some updated name"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Auto.update_car(car, @invalid_attrs)
      assert car == Auto.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Auto.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Auto.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Auto.change_car(car)
    end
  end
end
