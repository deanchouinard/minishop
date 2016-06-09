defmodule Tcart.Cache do
  use GenServer

  def start_link do
    IO.puts "Starting tcart cache."

    GenServer.start_link(__MODULE__, nil, name: :tcart_cache)
  end

  def server_process(tcart_cart_name) do
    GenServer.call(:tcart_cache, {:server_process, tcart_cart_name})
  end

  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:server_process, tcart_name}, _, tcart_servers) do
    case Map.fetch(tcart_servers, tcart_name) do
      {:ok, tcart_server} ->
        {:reply, tcart_server, tcart_servers}

      :error ->
        {:ok, new_server} = Tcart.Server.start_link(tcart_name)

        {:reply, new_server,
          Map.put(tcart_servers, tcart_name, new_server)
        }
    end
  end
end

