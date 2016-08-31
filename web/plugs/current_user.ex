defmodule Workshop.CurrentUser do
  import Plug.Conn

  alias Workshop.{Repo, User}

  def init(opts), do: opts

  def call(conn, _opts) do
    assign(conn, :current_user, user_from_session(conn))
  end

  defp user_from_session(conn) do
    case get_session(conn, :current_user_id) do
      nil -> nil
      val -> Repo.get(User, val)
    end
  end
end
