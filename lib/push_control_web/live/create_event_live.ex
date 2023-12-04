defmodule PushControlWeb.CreateEventLive do
  use PushControlWeb, :live_component

  alias PushControl.Events
  alias PushControl.Messages

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl h-[100dvh] flex flex-col justify-center">
      <.header class="text-center text-2xl">
        Send a one time message to your users
      </.header>

      <.simple_form
        for={@form}
        phx-submit="one_time_message"
        phx-target={@myself}
        phx-change="validate"
        phx-update="ignore"
      >
        <.input
          field={@form[:content]}
          name="content"
          label="Message"
          type="textarea"
          placeholder="Your message to be sent..."
          autocomplete="off"
          phx-debounce="blur"
          required
        />

        <:actions>
          <.button
            phx-disable-with="Sending request ..."
            class="w-full bg-default-brand dark:bg-darkMode-brand"
          >
            Send request <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def update(params, socket) do
    socket =
      assign(
        socket,
        current_user: params.current_user,
        form: to_form(Events.change_one_time_event(%PushControl.Events.One_Time_Event{}))
      )

    {:ok, socket}
  end

  def handle_event("validate", %{"content" => content}, socket) do
    one_time_event = socket.assigns.form.source.data

    changeset = Events.change_one_time_event(one_time_event, %{"content" => content})

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("event", %{"content" => content}, socket) do
    user_id = socket.assigns.current_user.id

    message_log_params = %{
      user_id: user_id
    }

    case Messages.create_message_log(message_log_params) do
      {:ok, message_log} ->
        one_time_event_params = %{
          user_id: user_id,
          content: content,
          message_log_id: message_log.id
        }

        case Events.create_one_time_event(one_time_event_params) do
          {:ok, _one_time_event} ->
            update_client_websocket("send_message", content, socket)
            {:noreply, socket}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, :form, to_form(changeset))}
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp update_client_websocket(_action, content, socket) do
    PushControlWeb.Endpoint.broadcast("room:lobby", "new_msg", %{body: content})
    {:noreply, socket}
  end
end
