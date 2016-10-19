defmodule Minishop.ProductControllerTest do
  use Minishop.ConnCase

  alias Minishop.Product
  @valid_attrs %{description: "some content", image_url: "some content", price:
    "120.5", title: "some content", sku: "1111"}
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
      get(conn, product_path(conn, :new)),
      get(conn, product_path(conn, :index)),
      get(conn, product_path(conn, :show, "123")),
      get(conn, product_path(conn, :edit, "123")),
      put(conn, product_path(conn, :update, "123", %{})),
      post(conn, product_path(conn, :create, %{})),
      delete(conn, product_path(conn, :delete, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag login_as: "max"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing products"
  end

  @tag login_as: "max"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, product_path(conn, :new)
    assert html_response(conn, 200) =~ "New product"
  end

  @tag login_as: "max"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @valid_attrs
    assert redirected_to(conn) == product_path(conn, :index)
    assert Repo.get_by(Product, @valid_attrs)
  end

  @tag login_as: "max"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @invalid_attrs
    assert html_response(conn, 200) =~ "New product"
  end

  @tag login_as: "max"
  test "shows chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, product_path(conn, :show, product)
    assert html_response(conn, 200) =~ "Show product"
  end

  @tag login_as: "max"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, product_path(conn, :show, -1)
    end
  end

  @tag login_as: "max"
  test "renders form for editing chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, product_path(conn, :edit, product)
    assert html_response(conn, 200) =~ "Edit product"
  end

  @tag login_as: "max"
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @valid_attrs
    assert redirected_to(conn) == product_path(conn, :show, product)
    assert Repo.get_by(Product, @valid_attrs)
  end

  @tag login_as: "max"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit product"
  end

  @tag login_as: "max"
  test "deletes chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = delete conn, product_path(conn, :delete, product)
    assert redirected_to(conn) == product_path(conn, :index)
    refute Repo.get(Product, product.id)
  end
end
