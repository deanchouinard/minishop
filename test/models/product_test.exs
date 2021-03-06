defmodule Minishop.ProductTest do
  use Minishop.ModelCase

  alias Minishop.Product

  @valid_attrs %{description: "some content", image_url: "some content", price:
    "120.5", title: "some content", sku: "001"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end
end
