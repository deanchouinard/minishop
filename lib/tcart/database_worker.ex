defmodule Tcart.DatabaseWorker do
  use GenServer

  alias Minishop.Repo
  alias Minishop.Session

  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder)
  end

  def store(key, data) do
    GenServer.cast(:database_server, {:store, key, data})
  end

  def get(key) do
   GenServer.call(:database_server, {:get, key})
  end

  def init(db_folder) do
    {:ok, db_folder}
  end

  def handle_cast({:store, key, data}, db_folder) do

    case session = Repo.get_by(Session, key: key) do
      nil -> Repo.insert!(%Session{key: key,
              cart_data: :erlang.term_to_binary(data)})

      session -> changeset = Session.changeset(session,
                   %{cart_data: :erlang.term_to_binary(data)})
        Repo.update(changeset)

    end

    {:noreply, db_folder}
  end

  def handle_call({:get, key}, _, db_folder) do
    cart_data = case Repo.get_by(Session, key: key) do
      nil -> nil
      %{cart_data: cart_data} = contents -> :erlang.binary_to_term(cart_data)
    end
    IO.inspect cart_data

    {:reply, cart_data, db_folder}
  end
end

