ExUnit.start

# Mix.Task.run "ecto.create", ~w(-r Minishop.Repo --quiet)
# Mix.Task.run "ecto.migrate", ~w(-r Minishop.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Minishop.Repo)

