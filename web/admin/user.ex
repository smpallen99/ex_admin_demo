defmodule ExAdminDemo.ExAdmin.User do
  use ExAdmin.Register
  import ExAdmin.ViewHelpers
  alias ExAdminDemo.Order
  alias ExAdminDemo.Repo

  register_resource ExAdminDemo.User do
    menu label: "Customers", priority: 4

    filter [:id, :username, :email, :inserted_at]

    show customer do
      panel "Order History" do
        table_for customer.orders do
          column "Order", [sortable: :id], fn(order) -> a " ##{order.id}", href: get_route_path(order, :show, order.id) end
          column "State", fn(order) -> status_tag(ExAdminDemo.Order.state order) end
          column :checked_out_at, label: "Date", sortable: true
          column "Total", fn(order) -> text decimal_to_currency(order.total_price) end
        end
      end   
    end

    query do
      %{all: [preload: :orders]}
    end

    sidebar "Customer Details", only: :show do
      attributes_table_for resource do
        row :username
        row :email
        row :inserted_at
      end
    end

    sidebar "Order History", only: :show do
      id = resource.id
      completed = where(Order, [o], o.user_id == ^id)
      |> Order.complete
      |> Repo.all
      attributes_table_for resource do
        row "Total Orders", fn(_) -> text Enum.count(completed) end
        row "Total Value", fn(_) -> 
          Enum.reduce(completed, Decimal.new(0.0), &(Decimal.add(&1.total_price, &2)))
          |> decimal_to_currency
          |> text
        end
      end
    end

    sidebar "ExAdmin Demo", only: [:index, :show] do
      Phoenix.View.render ExAdminDemo.AdminView, "sidebar_links.html", model: "users"
    end
  end
end
