defmodule Tcart.Cache do
  use GenServer

  def start_link do
    IO.puts "Starting tcart cache."

    GenServer.start_link(__MODULE__, nil, name: :tcart_cache)
  end

  def server_process(tcart_cart_name) do
    case Tcart.Server.whereis(tcart_cart_name) do
      :undefined ->
        GenServer.call(:tcart_cache, {:server_process, tcart_cart_name})

      pid -> pid
    end
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:server_process, tcart_cart_name}, _, state) do
    tcart_server_pid = case Tcart.Server.whereis(tcart_cart_name) do
      :undefined ->
        {:ok, pid} = Tcart.ServerSupervisor.start_child(tcart_cart_name)
        pid

      pid -> pid
    end
    {:reply, tcart_server_pid, state}
  end
end

