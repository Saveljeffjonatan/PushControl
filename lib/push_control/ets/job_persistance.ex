defmodule PushControl.Ets.JobPersistance do
  @filename "job_data.bin"

  def save_to_file do
    job_data = :ets.tab2list(:jobs)
    File.write!(@filename, :erlang.term_to_binary(job_data))
  end

  def load_from_file do
    case File.read(@filename) do
      {:ok, binary} ->
        :ets.from_dets(:jobs, :erlang.binary_to_term(binary))

      {:error, _reason} ->
        nil
        # Handle error (e.g., file not found)
    end
  end
end
