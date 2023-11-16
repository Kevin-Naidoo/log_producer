defmodule Metrics.Telemetry.ReporterState do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.update(__MODULE__, fn {count, duration, start_time} -> {count + 1, duration, start_time} end)
  end

  def restartCount do
    Agent.update(__MODULE__, fn {_count, duration, start_time} -> {0, duration, start_time} end)
  end

  def startClock(time) do
    Agent.update(__MODULE__, fn {count, duration, _start_time} -> {count, duration, time} end)
  end

  def elapsedTime do
    Agent.update(__MODULE__, fn {count, _duration, start_time} -> {count, :erlang.convert_time_unit((:erlang.monotonic_time() - start_time), :nanosecond, :millisecond), start_time} end)
  end
end
