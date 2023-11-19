defmodule PushControl.Messages.MessageLog do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "message_logs" do
    belongs_to :user, PushControl.Accounts.User
    has_many :events, PushControl.Events.Event
    has_many :one_time_events, PushControl.Events.One_Time_Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message_log, attrs) do
    message_log
    |> cast(attrs, [:user_id])
    |> cast_assoc(:events)
    |> cast_assoc(:one_time_events)
    |> validate_required([:user_id])
  end
end
