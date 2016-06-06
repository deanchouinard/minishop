defmodule Tcart.Cache do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def server_process(cache_pid, tcart_cart_name) do
    GenServer.call(cache_pid, {:server_process, tcart_cart_name})
  end

  def init(_) do
    Tcart.Database.start()
    {:ok, Map.new}
  end

  def handle_call({:server_process, tcart_name}, _, tcart_servers) do
    case Map.fetch(tcart_servers, tcart_name) do
      {:ok, tcart_server} ->
        {:reply, tcart_server, tcart_servers}

      :error ->
        {:ok, new_server} = Tcart.Server.start(tcart_name)

        {:reply, new_server,
          Map.put(tcart_servers, tcart_name, new_server)
        }
    end
  end
end

