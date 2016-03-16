defmodule ExAdminDemo.Repo do
  use Ecto.Repo, otp_app: :ex_admin_demo
  use Scrivener, page_size: 10
end
