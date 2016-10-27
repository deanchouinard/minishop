defmodule Minishop.Pay_TypeRepoTest do
  use Minishop.ModelCase
  alias Minishop.Pay_Type

  test "alphabetical/1 orders by code" do
    Repo.insert!(%Pay_Type{code: "c"})
    Repo.insert!(%Pay_Type{code: "a"})
    Repo.insert!(%Pay_Type{code: "b"})

    query = Pay_Type |> Pay_Type.alphabetical()
    query = from c in query, select: c.code
    assert Repo.all(query) == ~w(a b c)
  end
end


