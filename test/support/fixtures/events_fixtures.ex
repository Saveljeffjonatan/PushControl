defmodule PushControl.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PushControl.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(user, message, attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        archived_at: ~D[2023-11-13],
        enabled: true,
        end_time: ~D[2023-11-13],
        interval: ~T[00:05:00],
        start_time: ~D[2023-11-13]
      })
      |> PushControl.Events.create_event(user, message)

    event
  end
end
