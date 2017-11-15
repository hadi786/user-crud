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
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset, csrf_token: get_csrf_token())
    end
  end


  def list(conn, _params) do
    render conn, "list.html", users: Repo.all(User)
  end


  def edit(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      user when is_map(user) ->
        render conn, "edit.html", user: user , csrf_token: get_csrf_token()
      _ ->
        redirect conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")
    end
  end

  def update(conn, %{"id" => id} = params) do

    user = Repo.get(User, id)
    changeset = User.changeset(user, params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User has been updated successfully!")
        |> redirect(to: "/edit/"<>id)

      {:error, changeset} ->
        render conn, "list.html"
    end

  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    case user do
      user when is_map(user) ->
        Repo.delete(user)
        conn
        |> put_flash(:info, "User has been deleted successfully!")
        |> redirect(to: "/list/")
      _ ->
        redirect conn, Router.Helpers.page_path(page: "unauthorized")
    end
  end

end
