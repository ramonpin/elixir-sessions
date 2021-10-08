defmodule Mix.Tasks.ListFiles do
  @moduledoc """
  A sample tasks that executes an ls for the given directory. By deafult
  it gets the current directory.
  """
  use Mix.Task

  @spec run([binary]) :: :ok
  def run([]), do: run(["."])

  def run([dir]) when is_binary(dir) do
    System.cmd("ls", [dir])
    |> elem(0)
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.each(&IO.puts("Mix |> #{dir}/#{&1}"))
  end
end
