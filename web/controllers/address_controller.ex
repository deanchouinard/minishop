defmodule Minishop.AddressController do
  use Minishop.Web, :controller
  
  alias Minishop.Address

  import Ecto.Query

  plug :authenticate_user
  plug :scrub_params, "address" when action in [:create, :update]

  
  def index(conn, _params) do
    addresses = Repo.all(user_addresses(conn.assigns.current_user))
    render(conn, "index.html", addresses: addresses)
  end

  def new(conn, _params) do

    changeset = 
      conn.assigns.current_user
      |> build_assoc(:addresses)
      |> Address.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"address" => address_params}) do
    changeset =
      conn.assigns.current_user
      |> build_assoc(:addresses)
      |> Address.changeset(address_params)

    #    IO.inspect(changeset)

    case Repo.insert(changeset) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address created successfully.")
        |> redirect(to: address_path(conn, :show, address.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp user_addresses(user) do
    assoc(user, :addresses)
  end

end

