defmodule TestApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApp.Accounts.User


  schema "users" do
    field :email, :string
    field :fname, :string
    field :lname, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:fname, :lname, :email, :password])
    |> validate_required([:fname, :lname, :email, :password])
  end
end
