defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  def join(name, _auth_msg, socket) do
    IO.puts("++++")
    IO.puts(name)
    {:ok, %{mode: "decimation"}, socket}
  end

  def handle_in(name, message, socket) do
    IO.puts("++++")
    IO.puts(name)
    IO.inspect(message)
    {:reply, :ok, socket}
  end
end
