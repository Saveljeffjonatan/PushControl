defmodule PushControl.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :enabled, :boolean, default: false
    field :interval, :time
    field :start_time, :date
    field :end_time, :date
    field :archived_at, :date, default: nil
    belongs_to :user, PushControl.Accounts.User
    belongs_to :message, PushControl.Messages.Message
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
      :message_id,
      :message_log_id
    ])
    |> validate_required([
      :interval,
      :start_time,
      :end_time,
      :user_id,
      :message_id
    ])
  end
end
