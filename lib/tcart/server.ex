defmodule Tcart.Server do
  use GenServer

  def start_link(session_key) do
    IO.puts "Starting tcart server for #{session_key}."

    GenServer.start_link(Tcart.Server, session_key, name:
    via_tuple(session_key))
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

  def update_item(cart_server, item_id, updater_fun) do
    GenServer.cast(cart_server, {:update_item, item_id, updater_fun})
  end

  def delete_item(cart_server, item_id) do
    GenServer.cast(cart_server, {:delete_item, item_id})
  end

  def whereis(session_key) do
    :gproc.whereis_name({:n, :l, {:tcart_server, session_key}})
  end

  def init(session_key) do
    {:ok, {session_key, Tcart.Database.get(session_key) || Tcart.Cart.new}}
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

  def handle_cast({:add_item, new_item}, {session_key, tcart}) do
    new_state = Tcart.Cart.add_item(tcart, new_item)
    Tcart.Database.store(session_key, new_state)
    {:noreply, {session_key, new_state}}
  end

  def handle_cast({:update_item, item_id, updater_fun}, {session_key, tcart}) do
    new_state = Tcart.Cart.update_item(tcart, item_id, updater_fun)
    Tcart.Database.store(session_key, new_state)
    {:noreply, {session_key, new_state}}
  end

  def handle_cast({:delete_item, item_id}, {session_key, tcart}) do
    new_state = Tcart.Cart.delete_item(tcart, item_id)
    Tcart.Database.store(session_key, new_state)
    {:noreply, {session_key, new_state}}
  end

  defp via_tuple(name) do
    {:via, :gproc, {:n, :l, {:tcart_server, name}}}
  end

end
