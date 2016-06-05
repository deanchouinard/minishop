defmodule Tcart.Database do
  use GenServer

  def start() do
    GenServer.start(__MODULE__, nil,
      name: :database_server)
  end

  def store(key, data) do
    key
    |> choose_worker
    |> Tcart.DatabaseWorker.store(key, data)
  end

  def get(key) do
    key
    |> choose_worker
    |> Tcart.DatabaseWorker.get(key)
  end

  defp choose_worker(key) do
    GenServer.call(:database_server, {:choose_worker, key})
  end

  def handle_call({:choose_worker, key}, _, workers) do
    IO.puts "workers"
    IO.inspect workers
    worker_key = :erlang.phash2(key, 3)
    {:reply, Map.get(workers, worker_key), workers}
  end

  def init(_) do
    IO.puts "database init"
    {:ok, start_workers()}
  end

  defp start_workers() do
    IO.puts "started sw"
    tworkers = for index <- 1..3, into: %{} do
      {:ok, pid} = Tcart.DatabaseWorker.start()
      {index - 1, pid}
    end
    IO.puts "tworkers"
    IO.inspect tworkers
  end

end

