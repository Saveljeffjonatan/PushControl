defmodule PushControlWeb.DashboardHomeLive do
  use PushControlWeb, :live_view

  alias PushControl.Messages

  def render(assigns) do
    ~H"""
    <div class="mx-auto w-full grid grid-cols-2 gap-4 p-6">
      <div class="p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.header class="text-center text-2xl">
          Create events
        </.header>
      </div>
      <div class="p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.header class="text-center text-2xl">
          Schedule a message event to be sent at a later time
        </.header>
      </div>
      <div class="h-full relative col-span-2 p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.header class="text-center text-2xl">
          Message log of recent history
        </.header>
        <.table id="message_log_table" rows={@message_log}>
          <:col :let={item} label="Event Message">
            <%= Enum.map(item.one_time_events, fn event -> event.message.content end) %>
          </:col>
          <:col :let={item} label="Created at">
            <%= item.inserted_at %>
          </:col>
        </.table>
        <div class="absolute bottom-5 w-full flex justify-center items-center">
          <.button
            class="h-fit"
            phx-click="change_page"
            phx-value-page={@page_number - 1}
            disabled={@page_number == 1}
          >
            -
          </.button>
          <p class="p-4">Page <%= @page_number %> of <%= @total_pages %></p>
          <.button
            class="h-fit"
            phx-click="change_page"
            phx-value-page={@page_number + 1}
            disabled={@page_number == @total_pages}
          >
            +
          </.button>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    page_number = 1
    page_size = 6
    message_log = Messages.list_message_log(page_number, page_size)
    total_records = Messages.count_messages_in_log()

    total_pages =
      div(total_records, page_size) + if rem(total_records, page_size) > 0, do: 1, else: 0

    {:ok,
     assign(socket,
       message_log: message_log,
       page_number: page_number,
       total_pages: total_pages,
       page_size: page_size,
       total_records: total_records
     )}
  end

  def handle_event("change_page", %{"page" => page_number}, socket) do
    page_number = String.to_integer(page_number)
    page_size = socket.assigns.page_size

    message_log = Messages.list_message_log(page_number, page_size)

    {:noreply, assign(socket, message_log: message_log, page_number: page_number)}
  end
end
