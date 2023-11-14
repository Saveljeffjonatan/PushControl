defmodule PushControl.EventsTest do
  use PushControl.DataCase

  alias PushControl.Events

  describe "events" do
    alias PushControl.Events.Event

    import PushControl.EventsFixtures

    @invalid_attrs %{enabled: nil, interval: nil, start_time: nil, end_time: nil, archived_at: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{enabled: true, interval: ~T[14:00:00], start_time: ~D[2023-11-13], end_time: ~D[2023-11-13], archived_at: ~D[2023-11-13]}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.enabled == true
      assert event.interval == ~T[14:00:00]
      assert event.start_time == ~D[2023-11-13]
      assert event.end_time == ~D[2023-11-13]
      assert event.archived_at == ~D[2023-11-13]
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{enabled: false, interval: ~T[15:01:01], start_time: ~D[2023-11-14], end_time: ~D[2023-11-14], archived_at: ~D[2023-11-14]}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.enabled == false
      assert event.interval == ~T[15:01:01]
      assert event.start_time == ~D[2023-11-14]
      assert event.end_time == ~D[2023-11-14]
      assert event.archived_at == ~D[2023-11-14]
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
