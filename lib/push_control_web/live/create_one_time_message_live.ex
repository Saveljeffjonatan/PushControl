# defmodule PushControlWeb.CreateOneTimeMessageLive do
#   use PushControlWeb, :live_view

#   alias PushControl.{Events, Events.One_Time_Event}

#   def render(assigns) do
#     ~H"""
#     <div class="mx-auto max-w-2xl h-[100dvh] flex flex-col justify-center">
#       <.header class="text-center text-2xl">
#         Send a one time message to your users
#       </.header>

#       <.simple_form
#         for={@form}
#         id="event_form"
#         action={~p"/events/one_time_message"}
#         phx-update="ignore"
#       >
#         <.input field={@form[:event]} type="text" label="Message" required />

#         <:actions>
#           <.button
#             phx-disable-with="Sending request ..."
#             class="w-full bg-default-brand dark:bg-darkMode-brand"
#           >
#             Send request <span aria-hidden="true">→</span>
#           </.button>
#         </:actions>
#       </.simple_form>
#     </div>
#     """
#   end

#   def mount(_params, _session, socket) do
#     {:ok, socket}
#   end
# end
