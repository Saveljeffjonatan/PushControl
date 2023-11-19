defmodule PushControlWeb.DashboardHomeLive do
  use PushControlWeb, :live_view

  alias PushControl.Events
  alias PushControl.{Messages, Messages.Message}

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl h-[100dvh] flex flex-col justify-center">
      <.header class="text-center text-2xl">
        Send a one time message to your users
      </.header>

      <.simple_form
        for={@form}
        phx-submit="one_time_message"
        phx-change="validate"
        phx-update="ignore"
      >
        <.input
          field={@form[:event_message]}
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

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Messages.change_message(%Message{}))
      )

    {:ok, socket}
  end

  def handle_event("validate", %{"message" => params}, socket) do
    changeset =
      %Message{} |> Messages.change_message(params) |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("one_time_message", %{"message" => params}, socket) do
    # Step 1: Create a message
    params = %{"content" => params["event_message"]}

    case Messages.create_message(params) do
      {:ok, message} ->
        # Step 2: Create a one-time event

        message_log_params = %{
          message_id: message.id,
          user_id: socket.assigns.current_user.id
        }

        case Messages.create_message_log(message_log_params) do
          {:ok, message_log} ->
            {:noreply}

            one_time_event_params = %{
              message_id: message.id,
              user_id: socket.assigns.current_user.id,
              message_log_id: message_log.id
            }

            case Events.create_one_time_event(one_time_event_params) do
              {:ok, _one_time_event} ->
                {:noreply}
            end
        end

        # Clear the current form
        changeset = Messages.change_message(%Message{})

        {:noreply,
         assign(
           socket |> put_flash(:info, "Message successfully sent!"),
           :form,
           to_form(changeset)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         assign(
           socket |> put_flash(:error, changeset),
           :form,
           to_form(changeset)
         )}
    end
  end
end

# case Messages.create_message_log(message_log_params) do
#   {:ok, message_log} ->
#     # Handle success
#     {:noreply, assign(socket, :form, to_form(message_log.changeset))}

#   {:error, changeset} ->
#     # Handle error in message log creation
#     {:noreply, assign(socket, :form, to_form(changeset))}
# end
