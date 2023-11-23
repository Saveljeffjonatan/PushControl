defmodule PushControl.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias PushControl.Repo

  alias PushControl.Messages.Message

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  alias PushControl.Messages.MessageLog

  @doc """
  Returns the list of message_log.

  ## Examples

      iex> list_message_log()
      [%MessageLog{}, ...]

  """
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
