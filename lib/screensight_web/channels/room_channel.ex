defmodule ScreensightWeb.RoomChannel do
  use Phoenix.Channel

  alias ScreensightWeb.Presence

  def join("room:" <> _room_name, _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("new:chat:message", payload, socket) do
    broadcast!(socket, "new:chat:message", payload)
    {:noreply, socket}
  end

  def handle_in("new:video:chunk", payload, socket) do
    broadcast!(socket, "new:video:chunk", payload)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(socket, socket.assigns.user_id, %{
        online_at: inspect(System.system_time(:second))
      })

    {:noreply, socket}
  end
end
