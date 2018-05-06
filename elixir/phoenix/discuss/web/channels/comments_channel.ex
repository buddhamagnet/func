defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  def join(name, _auth_msg, socket) do
    {:ok, %{}, socket}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
