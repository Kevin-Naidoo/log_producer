defmodule LogProducer do
  require Logger
  alias Metrics.Telemetry

    @log_levels [:debug, :info, :error]

    @spec generate_random_logs(integer()) :: :ok
    def generate_random_logs(log_count) do
      Telemetry.ReporterState.startClock(:erlang.monotonic_time())
      Enum.each(1..log_count, fn _ ->
        random_log_level = Enum.random(@log_levels)
        random_log = generate_random_log()
        log_with_level(random_log_level, random_log)
        Metrics.count()
      end)
      Metrics.duration()
      TransferRate.tps()
    end

    def start_telemetry() do
      LogProducer.Application.start(1,2)
    end

    defp log_with_level(level, message) do
      Logger.log(level, message)
      IO.puts("Message Logged")
    end

    defp generate_random_log() do
      random_messages = [
        "A user submits a form.",
        "A user completes an action",
        "A card's content cannot be loaded",
        "A user's current session",
        "A system-related error occurs at random",
        "A page's content is inaccessible.",
        "A process that the user initiated."
      ]
      Enum.random(random_messages)
    end
end
