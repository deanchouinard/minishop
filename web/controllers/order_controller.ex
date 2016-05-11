defmodule Minishop.OrderController do
  use Minishop.Web, :controller

  alias Minishop.Order
  alias Minishop.Pay_Type
  alias Minishop.Product
  alias Minishop.Line_Item

  import Ecto.Query

  plug :scrub_params, "order" when action in [:create, :update]

  plug :load_pay_types when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    orders = Repo.all(Order)
    render(conn, "index.html", orders: orders)
  end

  def new(conn, _params) do
    cart = conn.assigns.cart
    dcart = Enum.reduce(cart, [], &Minishop.StoreController.conv_cart/2)

    changeset = Order.changeset(%Order{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    changeset = Order.changeset(%Order{}, order_params)

    IO.inspect(changeset)

    case Repo.insert(changeset) do
      {:ok, order} ->

        cart = conn.assigns.cart

        for i <- cart  do
          prod = Repo.one (from p in Product,
            where: p.id == ^i.prod_id,
            select: %{ id: p.id, title: p.title, price: p.price} )

          item_attrs = %{product_id: prod.id, quantity: i.qty, total_price: prod.price}
          item = Ecto.build_assoc(order, :line_items, item_attrs)
          item = Repo.insert!(item)
        end

        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: order_path(conn, :show, order.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    render(conn, "show.html", order: order)
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

  def load_pay_types(conn, _) do
    query =
      Pay_Type
      |> Pay_Type.alphabetical
      |> Pay_Type.code_and_ids
    pay_types = Repo.all query
    assign(conn, :pay_types, pay_types)
  end

end
