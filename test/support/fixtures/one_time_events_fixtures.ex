defmodule PushControl.OneTimeEventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PushControl.One_Time_Events` context.
  """

  @doc """
  Generate a one_time_event.
  """
  def one_time_event_fixture(attrs \\ %{}) do
    {:ok, one_time_event} =
      attrs
      |> Enum.into(%{})
      |> PushControl.Events.create_one_time_event()

    one_time_event
  end
end
