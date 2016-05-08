defmodule Minishop.OrderTest do
  use Minishop.ModelCase

  alias Minishop.Order

  @valid_attrs %{address: "some content", email: "some content", name: "some content", pay_type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
