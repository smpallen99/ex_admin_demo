defmodule ExAdminDemo.ExAdmin.Product do
  use ExAdmin.Register
  require Logger
  import Ecto.Query
  alias ExAdminDemo.Order
  alias ExAdminDemo.LineItem
  alias ExAdminDemo.Product
  alias ExAdminDemo.Repo

  register_resource ExAdminDemo.Product do
    menu priority: 2
    scope :all, default: true
    scope :available, [], fn(q) ->
      now = Ecto.Date.utc
      where(q, [p], p.available_on <= ^now)
    end
    scope :drafts, fn(q) ->
      now = Ecto.Date.utc
      where(q, [p], p.available_on > ^now)
    end
    scope :featured_products, [], fn(q) ->
      where(q, [p], p.featured == true)
    end

    index as: :grid, default: true, columns: 4 do
      import Kernel, except: [div: 2]
      cell fn(p) ->
        div ".box" do
          div ".box-body" do
            a href: admin_resource_path(p, :show) do
              img(src: ExAdminDemo.Image.url({p.image_file_name, p}, :thumb), height: 100)
            end
          end
        end
        div ".box-footer" do
          a truncate(p.title), href: admin_resource_path(p, :show)
        end
      end
    end

    show _product do
      attributes_table do
        row :title
        row :description
        row :author
        row :price
        row :featured
        row :available_on
        row "Cover", &(img(src: ExAdminDemo.Image.url({&1.image_file_name, &1}), height: 250))
      end
    end

    form product do
      inputs do
        input product, :title
        input product, :description
        input product, :author
        input product, :price
        input product, :featured
        input product, :available_on
        input product, :image_file_name, type: :file
      end
    end

    sidebar "Product Stats", only: :show do
      attributes_table_for resource do
        row "Total Sold", fn(r) ->
          Order.find_with_product(r)
          |> Repo.all
          |> Enum.count
          |> Integer.to_string
          |> text
        end
        row "Dollar Value", fn(r) ->
          id = r.id
          LineItem
          |> where([l], l.product_id == ^id)
          |> Repo.all
          |> Enum.reduce(Decimal.new(0.0), fn(li, sum) ->
            Decimal.add sum, li.price
          end)
          |> decimal_to_currency
          |> text
        end
      end
    end

    sidebar "ExAdmin Demo", only: [:index, :show] do
      Phoenix.View.render ExAdminDemo.AdminView, "sidebar_links.html", [model: "product"]
    end

  end
end
