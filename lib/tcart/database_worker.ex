defmodule Tcart.DatabaseWorker do
  use GenServer

  alias Minishop.Repo
  alias Minishop.Session

  def start() do
    GenServer.start(__MODULE__, nil)
  end

  def store(worker_pid, key, data) do
    GenServer.cast(worker_pid, {:store, key, data})
  end

  def get(worker_pid, key) do
    IO.puts "dw get"
   GenServer.call(worker_pid, {:get, key})
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:store, key, data}, _) do

    case session = Repo.get_by(Session, key: key) do
      nil -> Repo.insert!(%Session{key: key,
              cart_data: :erlang.term_to_binary(data)})

      session -> changeset = Session.changeset(session,
                   %{cart_data: :erlang.term_to_binary(data)})
        Repo.update(changeset)

    end

    {:noreply, nil}
  end

  def handle_call({:get, key}, _, _) do
    cart_data = case Repo.get_by(Session, key: key) do
      nil -> nil
      %{cart_data: cart_data} = contents -> :erlang.binary_to_term(cart_data)
    end
    IO.puts "dw handle call get"
    IO.inspect cart_data

    {:reply, cart_data, nil}
  end
end

