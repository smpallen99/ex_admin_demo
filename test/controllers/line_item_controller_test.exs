defmodule ExAdminDemo.LineItemControllerTest do
  use ExAdminDemo.ConnCase

  alias ExAdminDemo.LineItem
  @valid_attrs %{price: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, line_item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing line items"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, line_item_path(conn, :new)
    assert html_response(conn, 200) =~ "New line item"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, line_item_path(conn, :create), line_item: @valid_attrs
    assert redirected_to(conn) == line_item_path(conn, :index)
    assert Repo.get_by(LineItem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, line_item_path(conn, :create), line_item: @invalid_attrs
    assert html_response(conn, 200) =~ "New line item"
  end

  test "shows chosen resource", %{conn: conn} do
    line_item = Repo.insert! %LineItem{}
    conn = get conn, line_item_path(conn, :show, line_item)
    assert html_response(conn, 200) =~ "Show line item"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, line_item_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    line_item = Repo.insert! %LineItem{}
    conn = get conn, line_item_path(conn, :edit, line_item)
    assert html_response(conn, 200) =~ "Edit line item"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    line_item = Repo.insert! %LineItem{}
    conn = put conn, line_item_path(conn, :update, line_item), line_item: @valid_attrs
    assert redirected_to(conn) == line_item_path(conn, :show, line_item)
    assert Repo.get_by(LineItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    line_item = Repo.insert! %LineItem{}
    conn = put conn, line_item_path(conn, :update, line_item), line_item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit line item"
  end

  test "deletes chosen resource", %{conn: conn} do
    line_item = Repo.insert! %LineItem{}
    conn = delete conn, line_item_path(conn, :delete, line_item)
    assert redirected_to(conn) == line_item_path(conn, :index)
    refute Repo.get(LineItem, line_item.id)
  end
end
