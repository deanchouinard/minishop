defmodule Tcart.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    processes = [
      supervisor(Tcart.Database, []),
      supervisor(Tcart.ServerSupervisor, []),
      worker(Tcart.Cache, [])]
    supervise(processes, strategy: :one_for_one)
  end
end

