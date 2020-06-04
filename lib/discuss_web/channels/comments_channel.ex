defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  alias Discuss.{Topics, Comments, Repo}
  # alias Discuss.Comments

  @impl true
  def join("comments:" <> topic_id, _payload, socket) do
    topic_id = String.to_integer(topic_id)

    topic =
      Topics.get_topic!(topic_id)
      |> Repo.preload(comments: [:user]) #fetch nested associations

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  @impl true
  def handle_in(_name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user = socket.assigns.user_id

    case Comments.create_comment(topic, user, %{content: content}) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, %{error: reason}}, socket}
    end

    {:reply, :ok, socket}
  end
end
