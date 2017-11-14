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

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, hash_password(password))
      _ -> changeset
    end
  end

  def hash_password(password) do
    Comeonin.Bcrypt.hashpass(password, Comeonin.Bcrypt.gen_salt(12, true))
  end


  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:fname, :lname, :email, :password])
    |> validate_required([:fname, :lname, :email, :password])
    |> encrypt_password
  end




end
