defmodule PushControl.MessagesTest do
  use PushControl.DataCase

  alias PushControl.Messages

  describe "messages" do
    alias PushControl.Messages.Message

    import PushControl.MessagesFixtures

    @invalid_attrs %{content: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messages.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Message{} = message} = Messages.create_message(valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Message{} = message} = Messages.update_message(message, update_attrs)
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end

  describe "message_log" do
    alias PushControl.Messages.MessageLog

    import PushControl.MessagesFixtures

    @invalid_attrs %{}

    test "list_message_log/0 returns all message_log" do
      message_log = message_log_fixture()
      assert Messages.list_message_log() == [message_log]
    end

    test "get_message_log!/1 returns the message_log with given id" do
      message_log = message_log_fixture()
      assert Messages.get_message_log!(message_log.id) == message_log
    end

    test "create_message_log/1 with valid data creates a message_log" do
      valid_attrs = %{}

      assert {:ok, %MessageLog{} = message_log} = Messages.create_message_log(valid_attrs)
    end

    test "create_message_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message_log(@invalid_attrs)
    end

    test "update_message_log/2 with valid data updates the message_log" do
      message_log = message_log_fixture()
      update_attrs = %{}

      assert {:ok, %MessageLog{} = message_log} = Messages.update_message_log(message_log, update_attrs)
    end

    test "update_message_log/2 with invalid data returns error changeset" do
      message_log = message_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message_log(message_log, @invalid_attrs)
      assert message_log == Messages.get_message_log!(message_log.id)
    end

    test "delete_message_log/1 deletes the message_log" do
      message_log = message_log_fixture()
      assert {:ok, %MessageLog{}} = Messages.delete_message_log(message_log)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message_log!(message_log.id) end
    end

    test "change_message_log/1 returns a message_log changeset" do
      message_log = message_log_fixture()
      assert %Ecto.Changeset{} = Messages.change_message_log(message_log)
    end
  end
end
