defmodule TransferRate do
  alias Metrics.Telemetry.ReporterState

  def tps() do
    {total_count, elapsed_time_ms, _} = ReporterState.value()
    tps = (total_count/(elapsed_time_ms/1000))
    IO.puts("tps: #{tps}")
  end
end
