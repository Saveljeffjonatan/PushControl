defmodule PushControl.Repo.Migrations.CreateOneTimeEvents do
  use Ecto.Migration

  def change do
    create table(:one_time_events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :message_id, references(:messages, on_delete: :nothing, type: :binary_id)
      add :message_log_id, references(:message_logs_id, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:one_time_events, [:user_id])
    create index(:one_time_events, [:message_id])
    create index(:one_time_events, [:message_log_id])
  end
end
