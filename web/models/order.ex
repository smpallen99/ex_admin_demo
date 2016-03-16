defmodule ExAdminDemo.Order do
  use ExAdminDemo.Web, :model

  schema "orders" do
    field :checked_out_at, Ecto.DateTime
    field :total_price, :decimal
    belongs_to :user, ExAdminDemo.User

    timestamps
  end

  @required_fields ~w(checked_out_at total_price)
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
