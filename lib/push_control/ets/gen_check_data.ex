defmodule PushControl.Ets.GenCheckData do
  use GenServer

  alias PushControl.Ets.JobPersistance

  # Starts the GenServer
  # This function is called to start the GenServer process.
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{last_checked: nil}, opts)
  end

  # Initial setup of the GenServer
  # This function is called when the GenServer process is initialized.
  def init(state) do
    # Immediately schedule the first check
    schedule_check()
    {:ok, state}
  end

  # Handling the scheduled check
  # This function is called when the GenServer receives a :check_jobs message.
  def handle_info(:check_jobs, state) do
    # Read and schedule jobs based on the latest data
    read_and_schedule_jobs()

    # Update the last_checked timestamp in the state
    new_state = %{state | last_checked: DateTime.utc_now()}

    # Schedule the next check
    schedule_check()
    {:noreply, new_state}
  end

  # Function to schedule the next check
  # This sets up a message to be sent to the GenServer after a specified delay.
  defp schedule_check() do
    # Schedule the next :check_jobs message to be sent in 5 seconds
    Process.send_after(self(), :check_jobs, 5 * 1000)
  end

  # Read the job data file and schedule jobs
  # This function reads job data from the file and then schedules each job.
  defp read_and_schedule_jobs() do
    # Read job data from the file

    JobPersistance.load_from_file()
    |> IO.inspect(label: "job_data")

    # Schedule each job if it needs to run within the next hour
    # Enum.each(job_data, &schedule_if_within_next_hour/1)
  end

  # Schedule a job if it needs to run within the next hour
  # This function contains the logic for determining whether a job should be scheduled.
  # defp schedule_if_within_next_hour({job_name, job_info}) do
  #   # Add logic to determine if the job falls within the next hour
  #   # Schedule with Quantum if it does
  #   # ...
  # end
end
