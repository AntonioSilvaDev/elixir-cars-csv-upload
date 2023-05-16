defmodule CarsWeb.ErrorJSONTest do
  use CarsWeb.ConnCase, async: true

  test "renders 404" do
    assert CarsWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert CarsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
