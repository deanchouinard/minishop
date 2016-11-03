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
alias Minishop.User
alias Minishop.Address

import Ecto.Query

# Categories
categories = ["Shirts", "Pants", "Bats"]

for cat <- categories do
  category_params = %{name: cat}
  changeset = Category.changeset(%Category{}, category_params)
  Repo.get_by(Category, name: cat) ||
    Repo.insert!(changeset)
end

category_id = Repo.one(from c in Category, select: c.id, 
     where: c.name == "Bats", limit: 1)

# Products

products = [{"SKU0001", "First Product", "The first product",
  "https://localhost/first_product.jpg", 10.50},
  {"SKU0002", "Second Product", "The second product",
  "https://localhost/first_product.jpg", 123.45}, 
  {"SKU0003", "Third Product", "The third product",
  "https://localhost/first_product.jpg", 11.99}]

for {sku, title, description, image_url, price} <- products do
  product_params = %{sku: sku, title: title, description: description,
    image_url: image_url, price: price, category_id: category_id}

  changeset = Product.changeset(%Product{}, product_params)
  Repo.get_by(Product, title: title) ||
    Repo.insert!(changeset)

end

# pay_types
pay_types = [{"cc", "Credit Card"}, {"check", "Check"},
  {"po", "Purchase Order"}, {"cash", "Cash"}]

for {pt, desc} <- pay_types do
  Repo.get_by(Pay_Type, code: pt) ||
    Repo.insert!(%Pay_Type{code: pt, description: desc})
end


# alias Todo.Repo
# alias Todo.Priority
# alias Todo.User
# alias Todo.Task
# import Ecto.Query
#
user_params = %{name: "Deanch", username: "deanch", password: "deanch"}
changeset = User.registration_changeset(%User{}, user_params)
Repo.get_by(User, username: "deanch") ||
  Repo.insert!(changeset)
#
user = Repo.get_by(User, username: "deanch")
address_params = %{address1: "90 Elm Street", address2: "Suite 200",
  city: "Boston", state: "MA", zipcode: "12549", phone: "1234567890"}
address = Ecto.build_assoc(user, :addresses, address_params)
Repo.get_by(Address, address1: address.address1) ||
  Repo.insert!(address)
#
address_params = %{address1: "88 Dune Road", address2: "Apt. 4",
  city: "Dennis", state: "MA", zipcode: "05389", phone: "6784567890"}
address = Ecto.build_assoc(user, :addresses, address_params)
Repo.get_by(Address, address1: address.address1) ||
  Repo.insert!(address)
# for priority <- ~w(Low Medium High Ongoing) do
#   Repo.get_by(Priority, name: priority) ||
#     Repo.insert!(%Priority{name: priority})
# end
#
