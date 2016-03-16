defmodule ExAdminDemo.LineItemTest do
  use ExAdminDemo.ModelCase

  alias ExAdminDemo.LineItem

  @valid_attrs %{price: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LineItem.changeset(%LineItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LineItem.changeset(%LineItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
