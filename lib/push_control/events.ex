defmodule PushControl.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias PushControl.Repo

  alias PushControl.Events.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(user, message, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:user)

    message
    |> Ecto.build_assoc(:message)
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end

  alias PushControl.Events.One_Time_Event

  @doc """
  Returns the list of one_time_events.

  ## Examples

      iex> list_one_time_events()
      [%One_Time_Event{}, ...]

  """
  def list_one_time_events do
    Repo.all(One_Time_Event)
  end

  @doc """
  Gets a single one_time_event.

  Raises `Ecto.NoResultsError` if the One  time  event does not exist.

  ## Examples

      iex> get_one_time_event!(123)
      %One_Time_Event{}

      iex> get_one_time_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_one_time_event!(id), do: Repo.get!(One_Time_Event, id)

  @doc """
  Creates a one_time_event.

  ## Examples

      iex> create_one_time_event(%{field: value})
      {:ok, %One_Time_Event{}}

      iex> create_one_time_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_one_time_event(attrs \\ %{}) do
    %One_Time_Event{}
    |> One_Time_Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a one_time_event.

  ## Examples

      iex> update_one_time_event(one_time_event, %{field: new_value})
      {:ok, %One_Time_Event{}}

      iex> update_one_time_event(one_time_event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_one_time_event(%One_Time_Event{} = one_time_event, attrs) do
    one_time_event
    |> One_Time_Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a one_time_event.

  ## Examples

      iex> delete_one_time_event(one_time_event)
      {:ok, %One_Time_Event{}}

      iex> delete_one_time_event(one_time_event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_one_time_event(%One_Time_Event{} = one_time_event) do
    Repo.delete(one_time_event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking one_time_event changes.

  ## Examples

      iex> change_one_time_event(one_time_event)
      %Ecto.Changeset{data: %One_Time_Event{}}

  """
  def change_one_time_event(%One_Time_Event{} = one_time_event, attrs \\ %{}) do
    One_Time_Event.changeset(one_time_event, attrs)
  end
end
