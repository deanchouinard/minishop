defmodule Tcart.Cart do

  defstruct auto_id: 1, items: %{}

  #  def new, do: %Todo.List{}
  def new(items \\ []) do
    Enum.reduce(items, %Tcart.Cart{}, &add_item(&2, &1))
  end

  def size(tcart) do
    Map.size(tcart.items)
  end

  def add_item(
    %Tcart.Cart{items: items, auto_id: auto_id} = tcart,
    item) do
      item = Map.put(item, :id, auto_id)
      new_items = Map.put(items, auto_id, item)

      %Tcart.Cart{tcart | items: new_items, auto_id: auto_id + 1}
  end

  def items(%Tcart.Cart{items: items}, date) do
    items
    |> Stream.filter(fn({_, item}) ->
      item.date == date
    end)
    |> Enum.map(fn({_, item}) ->
      item
    end)
  end

  def line_items(%Tcart.Cart{items: items}, product_id) do
    items
    |> Stream.filter(fn({_, item}) ->
      item.product_id == product_id
    end)
    |> Enum.map(fn({_, item}) ->
      item
    end)
  end

  def list(%Tcart.Cart{items: items}) do
    items
    |> Enum.map(fn({_, item}) ->
      item
    end)
  end

  def update_item(tcart, %{} = new_item) do
    update_item(tcart, new_item.id, fn(_) -> new_item end)
  end

  def update_item(%Tcart.Cart{items: items} = tcart,
    item_id,
    updater_fun) do
    #      IO.inspect(entries[1])
      case items[item_id] do
        nil -> tcart

        old_item ->
          new_item = updater_fun.(old_item)
          new_itemss = Map.put(items, new_item.id, new_item)
          %Tcart.Cart{tcart | items: new_itemss}
      end
    end

  def delete_item(%Tcart.Cart{items: items} = tcart,
    item_id) do
    #      IO.inspect(entries[1])
      case items[item_id] do
        nil -> tcart

        _old_item ->
          new_items = Map.delete(items, item_id)
          %Tcart.Cart{tcart | items: new_items}
      end
    end
end

