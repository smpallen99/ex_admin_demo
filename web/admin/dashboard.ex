defmodule ExAdminDemo.ExAdmin.Dashboard do
  use ExAdmin.Register
  use ExAdmin.Page
  import Ecto.Query
  alias ExAdminDemo.Order
  alias ExAdminDemo.User
  alias ExAdminDemo.Repo

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    content do
      columns do
        column do
          panel "Recent Orders" do
            completed = where(Order, true)
            |> Order.complete
            |> limit(10)
            |> preload([:user])
            |> Repo.all
            table_for completed do
              column "State", fn(o) -> status_tag Order.state(o) end
              column "Customer", fn(o) -> 
                a o.user.email, href: "/admin/users/#{o.user.id}"
              end
              column "Total", fn(o) -> text decimal_to_currency(o.total_price) end 
            end
          end
        end
        column do
          panel "Recent Customers" do
            users = order_by(User, desc: :id)
            |> limit(10)
            |> Repo.all
            table_for users do
              column "email", fn(c) -> a c.email, href: "/admin/users/#{c.id}" end
            end
          end
        end
      end
      # columns do
      #   column do
      #     # markup :nested do
      #     panel "ExAdmin Demo" do
      #        #Phoenix.View.render ExAdminDemo.AdminView, "sidebar_links.html", [model: "dashboard"]
      #     end
      #     # end
      #   end
      # end
    end
  end
end
