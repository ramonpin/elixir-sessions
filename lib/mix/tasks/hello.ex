defmodule Mix.Tasks.Hello do
  @moduledoc """
  A sample mix task that just greets the world.
  """
  use Mix.Task

  @spec run([binary]) :: :ok
  def run(_) do
    Mix.shell().info("Hello world!!!")
  end
end
