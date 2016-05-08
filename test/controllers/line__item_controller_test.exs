defmodule Minishop.Line_ItemControllerTest do
  use Minishop.ConnCase

  alias Minishop.Line_Item
  @valid_attrs %{quantity: 42, total_price: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, line__item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing line items"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, line__item_path(conn, :new)
    assert html_response(conn, 200) =~ "New line  item"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, line__item_path(conn, :create), line__item: @valid_attrs
    assert redirected_to(conn) == line__item_path(conn, :index)
    assert Repo.get_by(Line_Item, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, line__item_path(conn, :create), line__item: @invalid_attrs
    assert html_response(conn, 200) =~ "New line  item"
  end

  test "shows chosen resource", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = get conn, line__item_path(conn, :show, line__item)
    assert html_response(conn, 200) =~ "Show line  item"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, line__item_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = get conn, line__item_path(conn, :edit, line__item)
    assert html_response(conn, 200) =~ "Edit line  item"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = put conn, line__item_path(conn, :update, line__item), line__item: @valid_attrs
    assert redirected_to(conn) == line__item_path(conn, :show, line__item)
    assert Repo.get_by(Line_Item, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = put conn, line__item_path(conn, :update, line__item), line__item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit line  item"
  end

  test "deletes chosen resource", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = delete conn, line__item_path(conn, :delete, line__item)
    assert redirected_to(conn) == line__item_path(conn, :index)
    refute Repo.get(Line_Item, line__item.id)
  end
end
