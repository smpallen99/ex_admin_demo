defmodule ExAdminDemo.Order do
  use ExAdminDemo.Web, :model
  alias ExAdminDemo.{Repo, Order, LineItem}
  import Ecto.Query

  @complete "complete"
  @in_progress "in_progress"

  schema "orders" do
    field :checked_out_at, Ecto.DateTime
    field :total_price, :decimal
    has_many :line_items, ExAdminDemo.LineItem
    belongs_to :user, ExAdminDemo.User

    timestamps
  end

  @required_fields ~w(user_id)
  @optional_fields ~w(checked_out_at total_price)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def recalculate_price!(order) do
    new_price = order.line_items
    |> Enum.reduce(Decimal.new(0.0), fn(li, acc) ->
      Decimal.add li.price, acc
    end)
    Repo.update! changeset(order, %{total_price: new_price})
  end

  def checkout!(order) do
    utc = Ecto.DateTime.utc
    Repo.update! changeset(order, %{checked_out_at: utc})
  end

  def state(order) do
    if order.checked_out_at, do: @complete, else: @in_progress
  end

  def find_with_product(product) do
    product_id = product.id
    Order
    |> where([o], not is_nil(o.checked_out_at))
    |> join(:inner, [o], l in LineItem, l.order_id == o.id)
    |> where([o, l], l.product_id == ^product_id)
    |> order_by([o,l], desc: o.checked_out_at)
  end

  def complete(query) do
    where(query, [p], not is_nil(p.checked_out_at))
  end

  def ordered(count) do
    where(Order, true)
    |> complete
    |> limit(^count)
    |> preload([:user])
  end

end
