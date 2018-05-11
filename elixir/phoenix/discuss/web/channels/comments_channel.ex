defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.{Topic, Comment}

  def join("comments:" <> id, _auth_msg, socket) do
    id = String.to_integer(id)

    topic =
      Topic
      |> Repo.get(id)
      |> Repo.preload(:comments)

    IO.inspect(topic)
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    changeset =
      socket.assigns.topic
      |> build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
