defmodule PushControlWeb.Utils.QuantumScheduler do
  import Crontab.CronExpression
  alias PushControl.Scheduler

  def schedule_job() do
    Scheduler.Quantum.new_job()
    |> Quantum.Job.set_name(:ticker)
    |> Quantum.Job.set_schedule(~e[1 * * * *]e)
    |> Quantum.Job.set_task(fn -> IO.puts("tick") end)
    |> Scheduler.Quantum.add_job()
  end

  # def create_cron_expression_from_event(%{start_time: start_time, interval: interval}) do
  #   {_hour, minute} = {start_time.hour, start_time.minute}
  #   interval_minutes = interval.minute + interval.hour * 60

  #   interval_expression = if interval_minutes > 0, do: "*/#{interval_minutes}", else: "*"

  #   "#{minute} #{interval_expression} * * *"
  # end

  def list_jobs(scheduler) do
    Scheduler.Quantum.jobs(scheduler)
  end
end
