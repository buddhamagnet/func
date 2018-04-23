defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn 
        |> put_flash(:info, "topic created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    case Repo.get(Topic, topic_id) do
      topic = %Topic{id: _id, title: _title} ->
        changeset = Topic.changeset(topic)
        render conn, "edit.html", changeset: changeset, topic: topic
    end
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    changeset = Repo.get(Topic, topic_id)
    |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn 
        |> put_flash(:info, "topic updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: topic
    end

    
  end
end
