defmodule Tcart do
  use Application
  
  def start(_type, _args) do
    Tcart.Supervisor.start_link()
  end
end

