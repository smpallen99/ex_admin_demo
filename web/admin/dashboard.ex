defmodule ExAdminDemo.ExAdmin.Dashboard do
  use ExAdmin.Register
  use ExAdmin.Page
  import Ecto.Query
  alias ExAdminDemo.{Order, Product, User, Repo}

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    content do
      columns do
        column do
          panel "Recent Orders" do
            Order.ordered(5)
            |> Repo.all
            |> table_for do
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
            User.ordered(5)
            |> Repo.all
            |> table_for do
              column "User Name", fn(c) -> a c.username, href: "/admin/users/#{c.id}" end
              column "Email", fn(c) -> text c.email end
            end
          end
        end
      end
      columns do
        column do
          panel "Statistics" do
            markup_contents do
              products = Repo.all(Product) |> Enum.count
              orders = Repo.all(Order) |> Enum.count
              users = Repo.all(User) |> Enum.count

              table ".table" do
                thead do
                  th "Item"
                  th "Total Count"
                end
                tbody do
                  tr do
                    td "Products"
                    td "#{products}"
                  end
                  tr do
                    td "Orders"
                    td "#{orders}"
                  end
                  tr do
                    td "Users"
                    td "#{users}"
                  end
                end
              end
            end
          end
        end
        column do
          panel "News" do
            markup_contents do
              table ".table" do
                tr do
                  td "ExAdmin 0.7.7 now supports multi-column panels!"
                end
                tr do
                  td "Checkout ExAdmin Github master for Ecto 2.0 support"
                end
              end
            end
          end
        end
        column do
          panel "ExAdmin Demo" do
            markup_contents do
              Phoenix.View.render(ExAdminDemo.AdminView, "sidebar_links.html", [model: "dashboard"])
              |> Phoenix.HTML.safe_to_string
              |> raw
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
