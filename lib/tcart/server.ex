defmodule Tcart.Server do
  use GenServer

  def start do
    GenServer.start(Tcart.Server, nil)
  end

  def add_item(cart_server, new_item) do
    GenServer.cast(cart_server, {:add_item, new_item})
  end

  def items(cart_server, date) do
    GenServer.call(cart_server, {:items, date})
  end

  def line_items(cart_server, product_id) do
    GenServer.call(cart_server, {:line_items, product_id})
  end

  def list(cart_server) do
    GenServer.call(cart_server, {:list})
  end

  def init(_) do
    {:ok, Tcart.Cart.new}
  end

  def handle_cast({:add_item, new_item}, tcart) do
    new_state = Tcart.Cart.add_item(tcart, new_item)
    {:noreply, new_state}
  end

  def handle_call({:items, date}, _, tcart) do
    {
      :reply,
      Tcart.Cart.items(tcart, date),
      tcart
    }
  end

  def handle_call({:list}, _, tcart) do
    {:reply, Tcart.Cart.list(tcart),
      tcart }
  end

  def handle_call({:line_items, product_id}, _, tcart) do
    {:reply, Tcart.Cart.line_items(tcart, product_id),
      tcart }
  end
end
