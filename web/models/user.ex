defmodule ExAdminDemo.User do
  use ExAdminDemo.Web, :model
  import Ecto.Query
  alias ExAdminDemo.{User}

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    has_many :orders, ExAdminDemo.Order

    timestamps
  end

  @required_fields ~w(username email)
  @optional_fields ~w(password_hash)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def ordered(count) do
    order_by(User, desc: :id)
    |> limit(^count)
  end
end
