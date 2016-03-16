defmodule ExAdminDemo.LineItem do
  use ExAdminDemo.Web, :model

  schema "line_items" do
    field :price, :decimal
    belongs_to :order, ExAdminDemo.Order
    belongs_to :product, ExAdminDemo.Product

    timestamps
  end

  @required_fields ~w(price)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
