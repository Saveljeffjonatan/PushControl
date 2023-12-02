defmodule PushControl.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :content, :string
    field :enabled, :boolean, default: false
    field :interval, :time
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :time_zone, :string
    field :archived_at, :date, default: nil
    belongs_to :user, PushControl.Accounts.User
    belongs_to :message_log, PushControl.Messages.MessageLog

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :enabled,
      :interval,
      :start_time,
      :end_time,
      :archived_at,
      :user_id,
      :content,
      :time_zone,
      :message_log_id
    ])
    |> validate_required([
      :start_time,
      :content,
      :user_id
    ])
  end
end
