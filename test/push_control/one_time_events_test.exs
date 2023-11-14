defmodule PushControl.One_Time_EventsTest do
  use PushControl.DataCase

  alias PushControl.One_Time_Events

  describe "one_time_events" do
    alias PushControl.One_Time_Events.One_Time_Event

    import PushControl.One_Time_EventsFixtures

    @invalid_attrs %{}

    test "list_one_time_events/0 returns all one_time_events" do
      one_time_event = one_time_event_fixture()
      assert One_Time_Events.list_one_time_events() == [one_time_event]
    end

    test "get_one_time_event!/1 returns the one_time_event with given id" do
      one_time_event = one_time_event_fixture()
      assert One_Time_Events.get_one_time_event!(one_time_event.id) == one_time_event
    end

    test "create_one_time_event/1 with valid data creates a one_time_event" do
      valid_attrs = %{}

      assert {:ok, %One_Time_Event{} = one_time_event} =
               One_Time_Events.create_one_time_event(valid_attrs)
    end

    test "create_one_time_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = One_Time_Events.create_one_time_event(@invalid_attrs)
    end

    test "update_one_time_event/2 with valid data updates the one_time_event" do
      one_time_event = one_time_event_fixture()
      update_attrs = %{}

      assert {:ok, %One_Time_Event{} = one_time_event} =
               One_Time_Events.update_one_time_event(one_time_event, update_attrs)
    end

    test "update_one_time_event/2 with invalid data returns error changeset" do
      one_time_event = one_time_event_fixture()

      assert {:error, %Ecto.Changeset{}} =
               One_Time_Events.update_one_time_event(one_time_event, @invalid_attrs)

      assert one_time_event == One_Time_Events.get_one_time_event!(one_time_event.id)
    end

    test "delete_one_time_event/1 deletes the one_time_event" do
      one_time_event = one_time_event_fixture()
      assert {:ok, %One_Time_Event{}} = One_Time_Events.delete_one_time_event(one_time_event)

      assert_raise Ecto.NoResultsError, fn ->
        One_Time_Events.get_one_time_event!(one_time_event.id)
      end
    end

    test "change_one_time_event/1 returns a one_time_event changeset" do
      one_time_event = one_time_event_fixture()
      assert %Ecto.Changeset{} = One_Time_Events.change_one_time_event(one_time_event)
    end
  end
end
