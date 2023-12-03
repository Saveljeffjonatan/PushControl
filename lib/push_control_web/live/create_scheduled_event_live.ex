defmodule PushControlWeb.CreateScheduledEventLive do
  use PushControlWeb, :live_view

  alias PushControl.Events
  alias PushControl.Messages

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl h-[100dvh] flex flex-col justify-center">
      <.header class="text-center text-2xl">
        Create New Event
      </.header>

      <.simple_form for={@form} phx-submit="create_event" phx-update="ignore">
        <div class="flex flex-col">
          <.input
            field={@form[:content]}
            label="Content"
            type="text"
            placeholder="Enter event content..."
            autocomplete="off"
            required
          />

          <div class="flex gap-2">
            <.input field={@form[:interval]} label="Interval" type="time" class="grow-1" />

            <.input field={@form[:start_time]} label="Start Time" type="datetime-local" />
          </div>

          <.input field={@form[:end_time]} label="End Time" type="datetime-local" />
        </div>
        <:actions>
          <.button
            phx-disable-with="Creating Event ..."
            class="w-full bg-default-brand dark:bg-darkMode-brand"
          >
            Create Event
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Events.change_event(%PushControl.Events.Event{}))
      )

    {:ok, socket}
  end

  def handle_event("create_event", %{"event" => event_params}, socket) do
    user_id = socket.assigns.current_user.id

    message_log_params = %{user_id: user_id}

    case Messages.create_message_log(message_log_params) do
      {:ok, message_log} ->
        %{"content" => content, "interval" => interval} = event_params
        utc_event_params = convert_to_utc(event_params)

        event_params_with_log_id = %{
          "user_id" => user_id,
          "content" => content,
          "interval" => interval,
          "start_time" => utc_event_params["start_time"],
          "end_time" => utc_event_params["end_time"],
          "time_zone" => utc_event_params["time_zone"] || "Etc/UTC",
          "message_log_id" => message_log.id
        }

        case Events.create_event(event_params_with_log_id) do
          {:ok, _event} ->
            # Handle successful event creation
            new_changeset = Events.change_event(%Events.Event{})
            {:noreply, assign(socket, form: to_form(new_changeset))}

          {:error, %Ecto.Changeset{} = changeset} ->
            # Handle error in creating event
            {:noreply, assign(socket, :form, to_form(changeset))}
        end

        new_changeset = Events.change_event(%Events.Event{})
        {:noreply, assign(socket, form: to_form(new_changeset))}

      {:error, _changeset} ->
        new_changeset = Events.change_event(%Events.Event{})
        {:noreply, assign(socket, form: to_form(new_changeset))}
    end
  end

  defp convert_to_utc(params) do
    # Fallback to a default time zone if not provided
    time_zone = Map.get(params, "time_zone", "Etc/UTC")

    start_time_utc = convert_datetime_to_utc(params["start_time"], time_zone)
    end_time_utc = convert_datetime_to_utc(params["end_time"], time_zone)

    %{params | "start_time" => start_time_utc, "end_time" => end_time_utc}
  end

  defp convert_datetime_to_utc(datetime, _tz) do
    case DateTime.from_iso8601("#{datetime}:00Z") do
      {:ok, datetime_utc, 0} ->
        DateTime.to_naive(datetime_utc)

      _error ->
        # Handle error, you might want to log this or default to a certain value
        datetime
    end
  end
end
