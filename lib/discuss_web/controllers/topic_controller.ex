defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller # Here we define that this is a controller
  # Every controller function receives 2 arguments, conn and params

  alias Discuss.Topics.Topic
  alias Discuss.Topics, as: Repo

  def index(conn, _params) do
    IO.inspect(conn.assigns, label: "Assigns: ")
    topics = Repo.list_topics()
    IO.inspect(topics)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Repo.create_topic(topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get_topic!(topic_id)
    changeset = Topic.changeset(topic, %{})
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get_topic!(topic_id)

    case Repo.update_topic(old_topic, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get_topic!(topic_id) |> Repo.delete_topic()

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
