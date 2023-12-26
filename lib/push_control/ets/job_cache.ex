defmodule PushControl.Ets.JobCache do
  use GenServer

  require Logger

  alias PushControl.Ets.JobPersistance

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :ets.new(:jobs, [:named_table, :public, :set])

    # Log the PID
    Logger.info("Starting JobCache GenServer with PID: #{inspect(self())}")

    # Load job data from file
    case JobPersistance.load_from_file() do
      :ok ->
        # If loading is successful, proceed with the normal state
        {:ok, %{}}

      {:error, :file_read_failed} ->
        # Handle error, such as by logging
        IO.inspect("Something went wrong with file reading")
        # Even in case of an error, you need to return a valid state
        {:ok, %{}}
    end
  end

  def add_job(job_id, data) do
    :ets.insert(:jobs, {job_id, data})
    # Persist the updated state
    JobPersistance.save_to_file()
  end

  # Function to retrieve job data
  def get_job(job_id) do
    :ets.lookup(:jobs, job_id)
  end
end
