defmodule DiscussWeb.UserSocket do
  use Phoenix.Socket

  # This file is like a router for channels
  ## Channels
  channel "comments:*", DiscussWeb.CommentsChannel

  # We receive de params argument from the params sent when creating the socket in socket.js
  @impl true
  def connect(%{"token" => token }, socket, _connect_info) do
    case Phoenix.Token.verify(socket, "key", token) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _reason} ->
        :error
    end
  end

  @impl true
  def id(_socket), do: nil
end
