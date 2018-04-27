defmodule Discuss.AuthController do
  use Discuss.Web, :controller

  alias Discuss.User

  plug(Ueberauth)

  def request(conn, _params) do
    render(conn, "index.html")
  end

  def callback(
        %{assigns: %{ueberauth_auth: %{credentials: %{token: token}, info: %{email: email}}}} =
          conn,
        _params
      ) do
    user_params = %{token: token, email: email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    sign_in(conn, changeset)
  end

  defp upsert_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

  defp sign_in(conn, changeset) do
    case upsert_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "welcome back #{user.email}!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn 
        |> put_flash(:error, "error signing in")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  def sign_out(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "come back soon!")
    |> redirect(to: topic_path(conn, :index))
  end
end
