defmodule Minishop.Line_ItemTest do
  use Minishop.ModelCase

  alias Minishop.Line_Item

  @valid_attrs %{quantity: 42, total_price: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Line_Item.changeset(%Line_Item{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Line_Item.changeset(%Line_Item{}, @invalid_attrs)
    refute changeset.valid?
  end
end
