defmodule PushControl.Repo.Migrations.CreateMessageLogs do
  use Ecto.Migration

  def change do
    create table(:message_logs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:message_logs, [:user_id])
  end
end
