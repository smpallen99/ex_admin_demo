defmodule ExAdminDemo.ProductTest do
  use ExAdminDemo.ModelCase

  alias ExAdminDemo.Product

  @valid_attrs %{author: "some content", available_on: "2010-04-17", description: "some content", featured: true, price: "120.5", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end
end
