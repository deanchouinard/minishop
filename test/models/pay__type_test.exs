defmodule Minishop.Pay_TypeTest do
  use Minishop.ModelCase

  alias Minishop.Pay_Type

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pay_Type.changeset(%Pay_Type{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pay_Type.changeset(%Pay_Type{}, @invalid_attrs)
    refute changeset.valid?
  end
end
