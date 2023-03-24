defmodule TerminateSample do
  use GenServer

  def start() do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(nil) do
    Process.flag(:trap_exit, true)
    {:ok, nil}
  end

  @impl GenServer
  def handle_call(:alive, _from, state) do
    {:reply, :im_alive, state}
  end

  @impl GenServer
  def handle_info({:EXIT, _from, :end_process}, state) do
    IO.puts("I will end myself")
    Process.exit(self(), :normal)
    {:noreply, state}
  end

  def handle_info({:EXIT, _from, reason}, state) do
    IO.puts("I will not get '#{reason}'")
    {:noreply, state}
  end
end
