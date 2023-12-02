defmodule PushControl.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias PushControl.Repo

  alias PushControl.Messages.MessageLog

  def list_message_log(page_number, page_size \\ 8) do
    MessageLog
    |> join(:inner, [m], ote in assoc(m, :one_time_events))
    |> group_by([m], m.id)
    |> preload(one_time_events: :message)
    |> limit(^page_size)
    |> order_by([m], desc: m.inserted_at)
    |> offset(^((page_number - 1) * page_size))
    |> Repo.all()
  end

  @doc """
  Return the count of message_log.

  ## Examples
      iex> count_message_log()
      100
  """
  def count_messages_in_log do
    one_time_event_subquery =
      from m in MessageLog,
        join: ote in assoc(m, :one_time_events),
        select: m.id,
        distinct: true

    query =
      from m in subquery(one_time_event_subquery),
        select: count(m.id)

    Repo.one(query)
  end

  @doc """
  Gets a single message_log.

  Raises `Ecto.NoResultsError` if the Message log does not exist.

  ## Examples

      iex> get_message_log!(123)
      %MessageLog{}

      iex> get_message_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message_log!(id), do: Repo.get!(MessageLog, id)

  @doc """
  Creates a message_log.

  ## Examples

      iex> create_message_log(%{field: value})
      {:ok, %MessageLog{}}

      iex> create_message_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message_log(attrs \\ %{}) do
    %MessageLog{}
    |> MessageLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message_log.

  ## Examples

      iex> update_message_log(message_log, %{field: new_value})
      {:ok, %MessageLog{}}

      iex> update_message_log(message_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message_log(%MessageLog{} = message_log, attrs) do
    message_log
    |> MessageLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message_log.

  ## Examples

      iex> delete_message_log(message_log)
      {:ok, %MessageLog{}}

      iex> delete_message_log(message_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message_log(%MessageLog{} = message_log) do
    Repo.delete(message_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message_log changes.

  ## Examples

      iex> change_message_log(message_log)
      %Ecto.Changeset{data: %MessageLog{}}

  """
  def change_message_log(%MessageLog{} = message_log, attrs \\ %{}) do
    MessageLog.changeset(message_log, attrs)
  end
end
