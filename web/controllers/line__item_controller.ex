defmodule Minishop.Line_ItemController do
  use Minishop.Web, :controller

  alias Minishop.Line_Item

  plug :scrub_params, "line__item" when action in [:create, :update]

  def index(conn, _params) do
    line_items = Repo.all(Line_Item)
    render(conn, "index.html", line_items: line_items)
  end

  def new(conn, _params) do
    changeset = Line_Item.changeset(%Line_Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"line__item" => line__item_params}) do
    changeset = Line_Item.changeset(%Line_Item{}, line__item_params)

    case Repo.insert(changeset) do
      {:ok, _line__item} ->
        conn
        |> put_flash(:info, "Line  item created successfully.")
        |> redirect(to: line__item_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    line__item = Repo.get!(Line_Item, id)
    render(conn, "show.html", line__item: line__item)
  end

  def edit(conn, %{"id" => id}) do
    line__item = Repo.get!(Line_Item, id)
    changeset = Line_Item.changeset(line__item)
    render(conn, "edit.html", line__item: line__item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "line__item" => line__item_params}) do
    line__item = Repo.get!(Line_Item, id)
    changeset = Line_Item.changeset(line__item, line__item_params)

    case Repo.update(changeset) do
      {:ok, line__item} ->
        conn
        |> put_flash(:info, "Line  item updated successfully.")
        |> redirect(to: line__item_path(conn, :show, line__item))
      {:error, changeset} ->
        render(conn, "edit.html", line__item: line__item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    line__item = Repo.get!(Line_Item, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(line__item)

    conn
    |> put_flash(:info, "Line  item deleted successfully.")
    |> redirect(to: line__item_path(conn, :index))
  end
end
