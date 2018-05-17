defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.{Topic, Comment}

  def join("comments:" <> id, _auth_msg, socket) do
    id = String.to_integer(id)

    topic =
      Topic
      |> Repo.get(id)
      |> Repo.preload(:comments)

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => content}, socket) do
    changeset =
      socket.assigns.topic
      |> build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    IO.inspect(socket.assigns)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        IO.puts("comments:#{socket.assigns.topic.id}:new")
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, _reason} ->
        IO.puts("ERROR")
        {:reply, {:error, %{errors: changeset}}, socket}

      true ->
        IO.puts("OTHER")
    end
  end
end
