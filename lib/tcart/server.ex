defmodule Tcart.Server do
  use GenServer

  def start(session_key) do
    GenServer.start(Tcart.Server, session_key)
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

  def init(session_key) do
    {:ok, {session_key, Tcart.Database.get(session_key) || Tcart.Cart.new}}
  end

  def handle_cast({:add_item, new_item}, {session_key, tcart}) do
    new_state = Tcart.Cart.add_item(tcart, new_item)
    Tcart.Database.store(session_key, new_state)
    {:noreply, {session_key, new_state}}
  end

  def handle_call({:items, date}, _, {session_key, tcart}) do
    {
      :reply,
      Tcart.Cart.items(tcart, date),
      {session_key, tcart}
    }
  end

  def handle_call({:list}, _, {session_key, tcart}) do
    {:reply, Tcart.Cart.list(tcart),
      {session_key, tcart} }
  end

  def handle_call({:line_items, product_id}, _, {session_key, tcart}) do
    {:reply, Tcart.Cart.line_items(tcart, product_id),
      {session_key, tcart} }
  end
end
