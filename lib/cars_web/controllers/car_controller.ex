defmodule CarsWeb.CarController do
  use CarsWeb, :controller

  alias Cars.Auto
  alias Cars.Auto.Car

  def index(conn, _params) do
    cars = Auto.list_cars()
    render(conn, :index, cars: cars)
  end

  def new(conn, _params) do
    changeset = Auto.change_car(%Car{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"car" => car_params}) do
    case Auto.create_car(car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car created successfully.")
        |> redirect(to: ~p"/cars/#{car}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    car = Auto.get_car!(id)
    render(conn, :show, car: car)
  end

  def edit(conn, %{"id" => id}) do
    car = Auto.get_car!(id)
    changeset = Auto.change_car(car)
    render(conn, :edit, car: car, changeset: changeset)
  end

  def update(conn, %{"id" => id, "car" => car_params}) do
    car = Auto.get_car!(id)

    case Auto.update_car(car, car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car updated successfully.")
        |> redirect(to: ~p"/cars/#{car}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, car: car, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    car = Auto.get_car!(id)
    {:ok, _car} = Auto.delete_car(car)

    conn
    |> put_flash(:info, "Car deleted successfully.")
    |> redirect(to: ~p"/cars")
  end

  def import(conn, %{"csv" => csv}) do
    # data = csv_decoder(csv)
    # result = import_cars(data)
    csv
    |> csv_decoder()
    |> import_cars()

    conn
    |> put_flash(:info, "Car imported successfully.")
    |> redirect(to: ~p"/cars")
  end

  defp import_cars(data) do
    cars = Enum.map(data, fn {:ok, car} -> parse(car) end)
    params = Auto.convert_params(cars)
    {_, _} = Auto.insert_cars(params)
  end

  defp csv_decoder(file) do
    require IEx; IEx.pry
    csv =
      "#{file.path}"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Enum.map(fn data -> data end)
  end

  defp parse(car) do
    fields = Auto.parse_fields(car)
  end
end
