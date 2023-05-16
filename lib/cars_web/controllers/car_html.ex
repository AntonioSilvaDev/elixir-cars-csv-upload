defmodule CarsWeb.CarHTML do
  use CarsWeb, :html

  embed_templates "car_html/*"

  @doc """
  Renders a car form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def car_form(assigns)
end
