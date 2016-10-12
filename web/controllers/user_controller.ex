defmodule Minishop.UserController do
  use Minishop.Web, :controller
  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
  #    case authenticate(conn) do
    #   %Plug.Conn{halted: true} = conn ->
      #   conn
    #conn ->
        users = Repo.all(Minishop.User)
        render conn, "index.html", users: users
        #end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Minishop.User, id)
    render conn, "show.html", user: user
  end

  alias Minishop.User
  
  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Minishop.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


end
