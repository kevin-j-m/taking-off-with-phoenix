defmodule Workshop.RegistrationController do
  use Workshop.Web, :controller

  alias Workshop.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Success")
        |> put_session(:current_user_id, user.id)
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
