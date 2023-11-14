defmodule PushControl.Events.One_Time_Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "one_time_events" do
    belongs_to :user, PushControl.Accounts.User
    belongs_to :message, PushControl.Messages.Message
    belongs_to :message_log, PushControl.Messages.MessageLog

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(one_time_event, attrs) do
    one_time_event
    |> cast(attrs, [:user_id, :message_id, :message_log_id])
    |> validate_required([:user_id, :message_id])
  end
end
