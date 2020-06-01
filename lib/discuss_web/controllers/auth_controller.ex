defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.Users

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    # pattern match the "provider" key inside params
    %{"provider" => provider} = params
    # get the info we need in our flow
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: provider}

    signin(conn, user_params)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp signin(conn, user_params) do
    case insert_or_update_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:info, "Error signin in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(user_params) do
    # if we find the user by the email, we return it, else we create it
    case Users.get_user_by_email(user_params.email) do
      nil ->
        Users.create_user(user_params)
      user ->
        {:ok, user}
    end
  end

end
