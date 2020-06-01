defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Users

  def init (_params) do

  end

  # In this case the params argument is whatever is returned by the init function,
  # in this case nothing. It also must return a connection
  def call(conn, _params) do
    user_id = conn |> get_session(:user_id)

    cond do
      user = user_id && Users.get_user!(user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end

end
