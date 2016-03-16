defmodule ExAdminDemo.LineItemController do
  use ExAdminDemo.Web, :controller

  alias ExAdminDemo.LineItem

  plug :scrub_params, "line_item" when action in [:create, :update]

  def index(conn, _params) do
    line_items = Repo.all(LineItem)
    render(conn, "index.html", line_items: line_items)
  end

  def new(conn, _params) do
    changeset = LineItem.changeset(%LineItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"line_item" => line_item_params}) do
    changeset = LineItem.changeset(%LineItem{}, line_item_params)

    case Repo.insert(changeset) do
      {:ok, _line_item} ->
        conn
        |> put_flash(:info, "Line item created successfully.")
        |> redirect(to: line_item_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    line_item = Repo.get!(LineItem, id)
    render(conn, "show.html", line_item: line_item)
  end

  def edit(conn, %{"id" => id}) do
    line_item = Repo.get!(LineItem, id)
    changeset = LineItem.changeset(line_item)
    render(conn, "edit.html", line_item: line_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "line_item" => line_item_params}) do
    line_item = Repo.get!(LineItem, id)
    changeset = LineItem.changeset(line_item, line_item_params)

    case Repo.update(changeset) do
      {:ok, line_item} ->
        conn
        |> put_flash(:info, "Line item updated successfully.")
        |> redirect(to: line_item_path(conn, :show, line_item))
      {:error, changeset} ->
        render(conn, "edit.html", line_item: line_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    line_item = Repo.get!(LineItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(line_item)

    conn
    |> put_flash(:info, "Line item deleted successfully.")
    |> redirect(to: line_item_path(conn, :index))
  end
end
