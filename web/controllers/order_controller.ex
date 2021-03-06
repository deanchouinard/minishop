defmodule Minishop.OrderController do
  use Minishop.Web, :controller

  alias Minishop.Order
  alias Minishop.Pay_Type
  alias Minishop.Product
  alias Minishop.Line_Item

  import Ecto.Query

  plug :authenticate_user
  plug :scrub_params, "order" when action in [:create, :update]

  plug :load_pay_types when action in [:new, :create, :edit, :update]
  
  def index(conn, _params) do
    orders = Repo.all(user_orders(conn.assigns.current_user))
    render(conn, "index.html", orders: orders)
  end

  def new(conn, _params) do
    cart = conn.assigns.cart
    dcart = build_display_cart(cart)

    changeset = 
      conn.assigns.current_user
      |> build_assoc(:orders)
      |> Order.changeset()

    user = conn.assigns.current_user
    addresses = Repo.all(assoc(user, :addresses))

      #    changeset = preload(changeset, :users)
      # IO.inspect changeset

      #    render(conn, "new.html", changeset: changeset)
    render(conn, "checkout.html", %{changeset: changeset, dcart: dcart,
         user: user, addresses: addresses})
  end

  def create(conn, %{"order" => order_params}) do
    changeset =
      conn.assigns.current_user
      |> build_assoc(:orders)
      |> Order.changeset(order_params)

    #    IO.inspect(changeset)

    case Repo.insert(changeset) do
      {:ok, order} ->

        cart = conn.assigns.cart

        for i <- cart  do
          prod = Repo.one (from p in Product,
            where: p.id == ^i.product_id,
            select: %{ id: p.id, title: p.title, price: p.price} )

          IO.puts "order create"
          IO.inspect i.qty
          IO.inspect prod.price
          item_total = Decimal.mult(Decimal.new(i.qty), prod.price)
          item_attrs = %{product_id: prod.id, quantity: i.qty,
              total_price: item_total}
          item = Ecto.build_assoc(order, :line_items, item_attrs)
          item = Repo.insert!(item)
        end

        conn = clear_cart(conn)
        #conn = assign(conn, :cart, cart)
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: order_path(conn, :show, order.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Repo.get!(user_orders(conn.assigns.current_user), id)
    line_items = Repo.all from i in Line_Item,
      where: i.order_id == ^id

    render(conn, "show.html", order: order, line_items: line_items)
  end

  def edit(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(order, order_params)

    case Repo.update(changeset) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: order_path(conn, :show, order))
      {:error, changeset} ->
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: order_path(conn, :index))
  end

  def clear_cart(conn) do
    cart_pid = conn.assigns.cart_pid
    cart = Tcart.Server.list(cart_pid)
    Enum.each(cart, fn(c) -> Tcart.Server.delete_item(cart_pid, c.id) end)
    conn = assign(conn, :cart, cart)
  end

  defp user_orders(user) do
    assoc(user, :orders)
  end

end
