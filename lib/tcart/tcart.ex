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

