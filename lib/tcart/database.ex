defmodule Tcart.Database do
  use GenServer

  alias Minishop.Repo
  alias Minishop.Session

  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder,
      name: :database_server)
  end

  def store(key, data) do
    GenServer.cast(:database_server, {:store, key, data})
  end

  def get(key) do
   GenServer.call(:database_server, {:get, key})
  end

  def init(db_folder) do
    workers = Enum.reduce(0..2, %{}, fn -> Tcart.DatabaseWorker.start end)
    {:ok, workers}
  end

  defp get_worker() do

  end
end

