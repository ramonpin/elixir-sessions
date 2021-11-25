defmodule MyTask do
  use Task

  def start_link(param),
    do: Task.start_link(__MODULE__, :thing_to_run, [param])

  def thing_to_run(param) when is_function(param, 0),
    do: IO.puts("Runnning task with #{param.()}")

  def thing_to_run(param),
    do: IO.puts("Runnning task with #{param}")
end
