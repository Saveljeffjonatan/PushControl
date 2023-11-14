defmodule PushControl.Repo do
  use Ecto.Repo,
    otp_app: :push_control,
    adapter: Ecto.Adapters.Postgres
end
