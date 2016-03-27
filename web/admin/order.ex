defmodule ExAdminDemo.ExAdmin.Order do
  use ExAdmin.Register
  alias ExAdminDemo.Order

  register_resource ExAdminDemo.Order do
    menu priority: 3

    scope :all, default: true
    scope :in_progress, fn(q) -> 
      where(q, [p], is_nil(p.checked_out_at))
    end
    scope :complete, fn(q) -> 
      where(q, [p], not is_nil(p.checked_out_at))
    end

    actions :all, only: [:index, :show]

    index do
      column "Order", fn(o) -> a " ##{o.id}", href: "/admin/orders/#{o.id}" end
      column "State", fn(o) -> 
        status_tag Order.state(o)
      end
      column :checked_out_at, label: "Date"
      column :user, label: "Customer", fields: [:username]
      column :total, fn(o) -> text decimal_to_currency(o.total_price) end
    end

    show order do
      panel "Invoice" do
        table_for(order.line_items) do
          column "Product", fn(item) ->  auto_link item.product end
          column "Price", fn(item) ->  text decimal_to_currency(item.price) end
        end
      end
    end

    query do
      %{all: [preload: [:user, line_items: [:product]]]}
    end

    sidebar "Order Total", only: :show do
      attributes_table_for resource  do
        row "Total", fn(order) -> text decimal_to_currency(order.total_price) end
      end
    end
    sidebar "Customer Information", only: :show do
      attributes_table_for resource.user do
        row "User", fn(c) -> auto_link c end
        row :email
      end
    end

    sidebar "ExAdmin Demo", only: [:index, :show] do
      Phoenix.View.render ExAdminDemo.AdminView, "sidebar_links.html", [model: "order"]
    end
  end

  def display_name(order) do
    decimal_to_currency(order.total_price) <>  
        " - Order ##{order.id} (#{order.user.username})"
  end
end
