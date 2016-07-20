defmodule ExAdminDemo.LineItem do
  use ExAdminDemo.Web, :model

  schema "line_items" do
    field :price, :decimal
    belongs_to :order, ExAdminDemo.Order
    belongs_to :product, ExAdminDemo.Product

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(price))
    |> validate_required([:price])
  end
end
