defmodule TestAppWeb.PageController do
  use TestAppWeb, :controller
  alias TestApp.Repo
  alias TestApp.Accounts.User
  import Ecto.Query, warn: false



  def index(conn, _params) do
    render(conn, "index.html", csrf_token: get_csrf_token())
  end

  def create(conn, params) do

    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User has been created successfully!")
        |> render("index.html", csrf_token: get_csrf_token())

      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset, csrf_token: get_csrf_token())
    end
  end

end
