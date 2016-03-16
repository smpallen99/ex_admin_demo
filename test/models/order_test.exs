defmodule ExAdminDemo.OrderTest do
  use ExAdminDemo.ModelCase

  alias ExAdminDemo.Order

  @valid_attrs %{checked_out_at: "2010-04-17 14:00:00", total_price: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
