defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.Topic

  def join("comments:" <> id = name, _auth_msg, socket) do
    id = String.to_integer(id)
    topic = Repo.get(Topic, id)
    {:ok, %{topic: topic}, socket}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
