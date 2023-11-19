defmodule PushControlWeb.DashboardHomeLive do
  use PushControlWeb, :live_view

  alias PushControlWeb.Components.Dashboard.{CreateOneTimeMessageComponent}

  def render(assigns) do
    ~H"""
    <div class="mx-auto w-full h-[100dvh] grid grid-cols-2 gap-4 p-10">
      <div class="p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.live_component module={CreateOneTimeMessageComponent} id="create-one-time-message" />
      </div>
      <div class="p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.header class="text-center text-2xl">
          Schedule a message event to be sent at a later time
        </.header>
      </div>
      <div class="p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.header class="text-center text-2xl">
          Send a one time message to your users
        </.header>
      </div>
      <div class="p-4 bg-default-gray dark:bg-darkMode-gray text-default-text dark:text-darkMode-text">
        <.header class="text-center text-2xl">
          Message log of recent history
        </.header>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
