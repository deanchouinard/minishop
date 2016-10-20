defmodule Minishop.Line_ItemControllerTest do
  use Minishop.ConnCase

  alias Minishop.Line_Item
  @valid_attrs %{quantity: 42, total_price: "120.5"}
  @invalid_attrs %{}

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, line__item_path(conn, :new)),
      get(conn, line__item_path(conn, :index)),
      get(conn, line__item_path(conn, :show, "123")),
      get(conn, line__item_path(conn, :edit, "123")),
      put(conn, line__item_path(conn, :update, "123", %{})),
      post(conn, line__item_path(conn, :create, %{})),
      delete(conn, line__item_path(conn, :delete, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end
  
  @tag login_as: "max"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, line__item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing line items"
  end

  @tag login_as: "max"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, line__item_path(conn, :new)
    assert html_response(conn, 200) =~ "New line  item"
  end

  @tag login_as: "max"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, line__item_path(conn, :create), line__item: @valid_attrs
    assert redirected_to(conn) == line__item_path(conn, :index)
    assert Repo.get_by(Line_Item, @valid_attrs)
  end

  @tag login_as: "max"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, line__item_path(conn, :create), line__item: @invalid_attrs
    assert html_response(conn, 200) =~ "New line  item"
  end

  @tag login_as: "max"
  test "shows chosen resource", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = get conn, line__item_path(conn, :show, line__item)
    assert html_response(conn, 200) =~ "Show line  item"
  end

  @tag login_as: "max"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, line__item_path(conn, :show, -1)
    end
  end

  @tag login_as: "max"
  test "renders form for editing chosen resource", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = get conn, line__item_path(conn, :edit, line__item)
    assert html_response(conn, 200) =~ "Edit line  item"
  end

  @tag login_as: "max"
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = put conn, line__item_path(conn, :update, line__item), line__item: @valid_attrs
    assert redirected_to(conn) == line__item_path(conn, :show, line__item)
    assert Repo.get_by(Line_Item, @valid_attrs)
  end

  @tag login_as: "max"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = put conn, line__item_path(conn, :update, line__item), line__item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit line  item"
  end

  @tag login_as: "max"
  test "deletes chosen resource", %{conn: conn} do
    line__item = Repo.insert! %Line_Item{}
    conn = delete conn, line__item_path(conn, :delete, line__item)
    assert redirected_to(conn) == line__item_path(conn, :index)
    refute Repo.get(Line_Item, line__item.id)
  end
end
