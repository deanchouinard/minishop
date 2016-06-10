defmodule Tcart.ServerSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil,
      name: :tcart_server_supervisor )
  end

  def start_child(tcart_cart_name) do
    Supervisor.start_child(
      :tcart_server_supervisor,
      [tcart_cart_name] )
  end

  def init(_) do
    supervise(
    [worker(Tcart.Server, [])],
    strategy: :simple_one_for_one
    )
  end
end

