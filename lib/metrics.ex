defmodule Metrics do
  def count do
    :telemetry.execute([:metrics, :count], %{})
  end

  def duration do
    :telemetry.execute([:metrics, :duration], %{})
  end
end
