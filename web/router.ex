defmodule ExAdminDemo.Router do
  use ExAdminDemo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExAdminDemo do
    pipe_through :browser # Use the default browser stack

    resources "/products", ProductController
    resources "/users", UserController
    resources "/orders", OrderController
    resources "/line_items", LineItemController
    
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExAdminDemo do
  #   pipe_through :api
  # end
end
