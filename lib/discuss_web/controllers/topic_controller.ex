defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller # Here we define that this is a controller
  # Every controller function receives 2 arguments, conn and params

  alias Discuss.Topics.Topic
  alias Discuss.Topics

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = Topics.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Topics.get_topic!(topic_id)
    render(conn, "show.html", topic: topic)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Topics.create_topic(conn.assigns.user, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Topics.get_topic!(topic_id)
    changeset = Topic.changeset(topic, %{})
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Topics.get_topic!(topic_id)

    case Topics.update_topic(old_topic, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Topics.get_topic!(topic_id) |> Topics.delete_topic()

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  # Since this is a plug function, the params it receives behave in the way the params plug work
  # which is anything that the init function returns, in this case again is nothing because this isn't a
  # module plug, but rather function plug
  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn
    if Topics.get_topic!(topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "Forbidden operation")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
