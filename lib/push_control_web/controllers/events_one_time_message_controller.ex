defmodule PushControlWeb.EventsOneTimeMessageController do
  use PushControlWeb, :controller

  alias PushControl.Events

  def create(conn, %{"_action" => "one_time_message"} = params) do
    one_time_message(conn, params, "Message successfully created")
  end

  defp one_time_message(conn, %{"event" => event_params}, info) do
    if Events.create_one_time_event(event_params) do
      conn
      |> put_flash(:info, info)
    else
      conn
      |> put_flash(:error, "Failed to store message")
    end
  end
end
