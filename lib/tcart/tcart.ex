defmodule CartServer do
  use GenServer

  def start do
    GenServer.start(CartServer, nil)
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
    {:ok, Minishop.Tcart.new}
  end

  def handle_cast({:add_item, new_item}, tcart) do
    new_state = Minishop.Tcart.add_item(tcart, new_item)
    {:noreply, new_state}
  end

  def handle_call({:items, date}, _, tcart) do
    {
      :reply,
      Minishop.Tcart.items(tcart, date),
      tcart
    }
  end

  def handle_call({:list}, _, tcart) do
    {:reply, Minishop.Tcart.list(tcart),
      tcart }
  end

  def handle_call({:line_items, product_id}, _, tcart) do
    {:reply, Minishop.Tcart.line_items(tcart, product_id),
      tcart }
  end
end

defmodule Minishop.Tcart do

  defstruct auto_id: 1, items: %{}

  #  def new, do: %Todo.List{}
  def new(items \\ []) do
    Enum.reduce(items, %Minishop.Tcart{}, &add_item(&2, &1))
  end

  def size(tcart) do
    HashDict.size(tcart.items)
  end

  def add_item(
    %Minishop.Tcart{items: items, auto_id: auto_id} = tcart,
    item) do
      item = Map.put(item, :id, auto_id)
      new_items = Map.put(items, auto_id, item)

      %Minishop.Tcart{tcart | items: new_items, auto_id: auto_id + 1}
  end

  def items(%Minishop.Tcart{items: items}, date) do
    items
    |> Stream.filter(fn({_, item}) ->
      item.date == date
    end)
    |> Enum.map(fn({_, item}) ->
      item
    end)
  end

  def line_items(%Minishop.Tcart{items: items}, product_id) do
    items
    |> Stream.filter(fn({_, item}) ->
      item.product_id == product_id
    end)
    |> Enum.map(fn({_, item}) ->
      item
    end)
  end

  def list(%Minishop.Tcart{items: items}) do
    items
    |> Enum.map(fn({_, item}) ->
      item
    end)
  end

  def update_item(tcart, %{} = new_item) do
    update_item(tcart, new_item.id, fn(_) -> new_item end)
  end

  def update_item(%Minishop.Tcart{items: items} = tcart,
    item_id,
    updater_fun) do
    #      IO.inspect(entries[1])
      case items[item_id] do
        nil -> tcart

        old_item ->
          new_item = updater_fun.(old_item)
          new_itemss = Map.put(items, new_item.id, new_item)
          %Minishop.Tcart{tcart | items: new_itemss}
      end
    end

  def delete_item(%Minishop.Tcart{items: items} = tcart,
    item_id) do
    #      IO.inspect(entries[1])
      case items[item_id] do
        nil -> tcart

        old_item ->
          new_items = Map.delete(items, item_id)
          %Minishop.Tcart{tcart | items: new_items}
      end
    end
end

