defmodule Tcart.Database do
  @pool_size 3

  def start_link() do
    IO.puts "Database starting."
    Tcart.PoolSupervisor.start_link(@pool_size)
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
    :erlang.phash2(key, @pool_size) + 1
  end

end

