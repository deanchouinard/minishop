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
    %Todo.List{items: items, auto_id: auto_id} = tcart,
    item) do
      item = Map.put(item, :id, auto_id)
      new_items = Map.put(items, auto_id, item)

      %Minishop.Tcart{tcart | items: new_items, auto_id: auto_id + 1}
  end

  def entries(%Todo.List{entries: entries}, date) do
    entries
    |> Stream.filter(fn({_, entry}) ->
      entry.date == date
    end)
    |> Enum.map(fn({_, entry}) ->
      entry
    end)
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn(_) -> new_entry end)
  end

  def update_entry(%Todo.List{entries: entries} = todo_list,
    entry_id,
    updater_fun) do
    #      IO.inspect(entries[1])
      case entries[entry_id] do
        nil -> todo_list

        old_entry ->
          new_entry = updater_fun.(old_entry)
          new_entries = HashDict.put(entries, new_entry.id, new_entry)
          %Todo.List{todo_list | entries: new_entries}
      end
    end

  def delete_entry(%Todo.List{entries: entries} = todo_list,
    entry_id) do
    #      IO.inspect(entries[1])
      case entries[entry_id] do
        nil -> todo_list

        old_entry ->
          new_entries = HashDict.delete(entries, entry_id)
          %Todo.List{todo_list | entries: new_entries}
      end
    end
end

