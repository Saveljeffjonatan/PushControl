defmodule PushControl.Ets.JobPersistance do
  @filename "job_data.bin"
  require Logger

  def save_to_file do
    job_data =
      :ets.tab2list(:jobs)
      |> IO.inspect(label: "job_data")

    File.write!(@filename, :erlang.term_to_binary(job_data))
  end

  def load_from_file do
    case File.read(@filename) do
      {:ok, binary} ->
        job_data = :erlang.binary_to_term(binary)
        # Log the job data for inspection
        Logger.info("Job data loaded: #{inspect(job_data)}")

        # Assuming job_data is a list of tuples suitable for ETS insertion
        :ets.insert(:jobs, job_data)
        # Indicate success
        :ok

      {:error, reason} ->
        # Log the error
        Logger.error("Failed to read file: #{inspect(reason)}")
        {:error, :file_read_failed}
    end
  end
end
