defmodule PushControlWeb.PageController do
  use PushControlWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/dashboard")
  end
end
