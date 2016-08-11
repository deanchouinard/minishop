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
alias Minishop.Pay_Type
alias Minishop.Category

import Ecto.Query

# Categories

category_params = %{name: "Bats"}
changeset = Category.changeset(%Category{}, category_params)
Repo.get_by(Category, name: "Bats") ||
  Repo.insert!(changeset)

category_id = Repo.one(from c in Category, select: c.id, limit: 1)

# Products

product_params = %{sku: "SKU0001", title: "First Product", description: "The first product",
  image_url: "https://localhost/first_product.jpg", price: 10.50,
  category_id: category_id}
changeset = Product.changeset(%Product{}, product_params)
Repo.get_by(Product, title: "First Product") ||
  Repo.insert!(changeset)

product_params = %{sku: "SKU0002", title: "Second Product", description: "The second product",
  image_url: "https://localhost/first_product.jpg", price: 123.45,
  category_id: category_id}
changeset = Product.changeset(%Product{}, product_params)
Repo.get_by(Product, title: "Second Product") ||
  Repo.insert!(changeset)

# pay_types

Repo.get_by(Pay_Type, code: "cc") ||
  Repo.insert!(%Pay_Type{code: "cc", description: "Credit card"})

Repo.get_by(Pay_Type, code: "check") ||
  Repo.insert!(%Pay_Type{code: "check", description: "Check"})

Repo.get_by(Pay_Type, code: "po") ||
  Repo.insert!(%Pay_Type{code: "po", description: "Purchase order"})


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
