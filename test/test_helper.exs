ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ExAdminDemo.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ExAdminDemo.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ExAdminDemo.Repo)

