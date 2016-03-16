defmodule ExAdminDemo.PageController do
  use ExAdminDemo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
