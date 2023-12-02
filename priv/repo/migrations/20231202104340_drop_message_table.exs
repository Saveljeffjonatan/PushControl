defmodule PushControl.Repo.Migrations.DropMessageTable do
  use Ecto.Migration

  def change do
    # Add a content field to events table
    alter table(:events) do
      add :content, :text
    end

    # Add a content field to one_time_events table
    alter table(:one_time_events) do
      add :content, :text
    end

    # Assuming the message table is named `messages`
    # and other tables have a `message_id` foreign key
    # to this table, you need to remove these associations first.
    # Example for a table with message_id:

    alter table(:one_time_events) do
      remove :message_id
    end

    alter table(:events) do
      remove :message_id
    end

    drop table(:messages)
  end
end
