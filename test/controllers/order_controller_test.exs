defmodule Minishop.OrderControllerTest do
  use Minishop.ConnCase

  alias Minishop.Order
  alias Minishop.Pay_Type
#  @valid_attrs %{address: "some content", email: "some content", name: "some
#  content"}
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{user: user} do
    {:ok, pay_type} = Pay_Type.changeset(%Pay_Type{}, %{code: "cc",
      description: "Credit Card"}) |> Repo.insert
    valid_attrs = Dict.merge(%{pay_type_id: pay_type.id, user_id: user.id}, @valid_attrs)
    {:ok, valid_attrs: valid_attrs}
  end

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, order_path(conn, :new)),
      get(conn, order_path(conn, :index)),
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

  @tag login_as: "max"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, order_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing orders"
  end

  @tag login_as: "max"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, order_path(conn, :new)
    assert html_response(conn, 200) =~ "Checkout"
  end

  @tag login_as: "max"
  test "creates resource and redirects when data is valid", %{conn: conn,
    valid_attrs: valid_attrs, user: user} do
    IO.inspect valid_attrs
    conn = post conn, order_path(conn, :create), order: valid_attrs
    order = Repo.get_by(Order, valid_attrs)
    assert redirected_to(conn) == order_path(conn, :show, order.id )
    assert order.user_id == user.id
  end

  @tag login_as: "max"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, order_path(conn, :create), order: @invalid_attrs
    assert html_response(conn, 200) =~ "New order"
  end

  @tag login_as: "max"
  test "shows chosen resource", %{conn: conn, valid_attrs: valid_attrs} do
    {:ok, order} = Order.changeset(%Order{}, valid_attrs) |> Repo.insert
    # order = Repo.insert! %Order{valid_attrs}
    conn = get conn, order_path(conn, :show, order)
    assert html_response(conn, 200) =~ "Show order"
  end

  @tag login_as: "max"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, order_path(conn, :show, -1)
    end
  end

  @tag login_as: "max"
  test "authorizes actions against access by other users",
    %{user: owner, conn: conn, valid_attrs: valid_attrs} do

      order = insert_order(owner, valid_attrs)
      non_owner = insert_user(username: "sneaky")
      conn = assign(conn, :current_user, non_owner)

      assert_error_sent :not_found, fn ->
        get(conn, order_path(conn, :show, order))
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
