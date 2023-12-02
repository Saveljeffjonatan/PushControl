defmodule PushControl.Repo.Migrations.AlterEventsTimezones do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :time_zone, :string
      modify :start_time, :utc_datetime
      modify :end_time, :utc_datetime
    end
  end
end
