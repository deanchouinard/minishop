defmodule Minishop.OrderControllerTest do
  use Minishop.ConnCase

  alias Minishop.Order
  @valid_attrs %{address: "some content", email: "some content", name: "some
  content", pay_type_id: 1}
  @invalid_attrs %{}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, order_path(conn, :new)),
      #get(conn, order_path(conn, :index)),
      get(conn, order_path(conn, :show, "123")),
      #get(conn, order_path(conn, :edit, "123")),
      #put(conn, order_path(conn, :update, "123", %{})),
      post(conn, order_path(conn, :create, %{})),
      #delete(conn, order_path(conn, :delete, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag :skip
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, order_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing orders"
  end

  @tag login_as: "max"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, order_path(conn, :new)
    assert html_response(conn, 200) =~ "New order"
  end

  @tag :skip
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, order_path(conn, :create), order: @valid_attrs
    assert redirected_to(conn) == order_path(conn, :index )
    assert Repo.get_by(Order, @valid_attrs)
  end

  @tag login_as: "max"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, order_path(conn, :create), order: @invalid_attrs
    assert html_response(conn, 200) =~ "New order"
  end

  @tag :skip
  test "shows chosen resource", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = get conn, order_path(conn, :show, order)
    assert html_response(conn, 200) =~ "Show order"
  end

  @tag login_as: "max"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, order_path(conn, :show, -1)
    end
  end

  @tag :skip
  test "renders form for editing chosen resource", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = get conn, order_path(conn, :edit, order)
    assert html_response(conn, 200) =~ "Edit order"
  end

  @tag :skip
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = put conn, order_path(conn, :update, order), order: @valid_attrs
    assert redirected_to(conn) == order_path(conn, :show, order)
    assert Repo.get_by(Order, @valid_attrs)
  end

  @tag :skip
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = put conn, order_path(conn, :update, order), order: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit order"
  end

  @tag :skip
  test "deletes chosen resource", %{conn: conn} do
    order = Repo.insert! %Order{}
    conn = delete conn, order_path(conn, :delete, order)
    assert redirected_to(conn) == order_path(conn, :index)
    refute Repo.get(Order, order.id)
  end
end
