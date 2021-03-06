defmodule Minishop.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  import Minishop.TestHelpers
  use Phoenix.ConnTest

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Minishop.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      import Minishop.Router.Helpers
      import Minishop.TestHelpers

      # The default endpoint for testing
      @endpoint Minishop.Endpoint
    end
  end

  setup tags do
    # unless tags[:async] do
    #   Ecto.Adapters.SQL.restart_test_transaction(Minishop.Repo, [])
    # end
    
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Minishop.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Minishop.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()

    if username = tags[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      {:ok, conn: conn, user: %Minishop.User{}}
      #{:ok, conn: Phoenix.ConnTest.build_conn()}
    end
  end
end
