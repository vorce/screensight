defmodule ScreensightWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> _room_name, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new:chat:message", payload, socket) do
    broadcast!(socket, "new:chat:message", payload)
    {:noreply, socket}
  end
end
