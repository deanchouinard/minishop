# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todo.Repo.insert!(%Todo.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Minishop.Repo
alias Minishop.Product
import Ecto.Query

product_params = %{title: "First Product", description: "The first product",
  image_url: "https://localhost/first_product.jpg", price: 10.50}
changeset = Product.changeset(%Product{}, product_params)
Repo.get_by(Product, title: "First Product") ||
  Repo.insert!(changeset)


# alias Todo.Repo
# alias Todo.Priority
# alias Todo.User
# alias Todo.Task
# import Ecto.Query
#
# user_params = %{name: "Deanch", username: "deanch", password: "deanch"}
# changeset = User.registration_changeset(%User{}, user_params)
# Repo.get_by(User, username: "deanch") ||
#   Repo.insert!(changeset)
#
# user = Repo.get_by(User, username: "deanch")
# attrs = %{date: "2014/06/12", title: "Shopping"}
# task = Ecto.build_assoc(user, :tasks, attrs)
# Repo.get_by(Task, user_id: user.id) ||
#   Repo.insert!(task)
#
# for priority <- ~w(Low Medium High Ongoing) do
#   Repo.get_by(Priority, name: priority) ||
#     Repo.insert!(%Priority{name: priority})
# end
#
