defmodule PushControl.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PushControl.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> PushControl.Messages.create_message()

    message
  end

  @doc """
  Generate a message_log.
  """
  def message_log_fixture(attrs \\ %{}) do
    {:ok, message_log} =
      attrs
      |> Enum.into(%{

      })
      |> PushControl.Messages.create_message_log()

    message_log
  end
end
