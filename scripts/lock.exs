defmodule Light do
  use GenServer
  
  def start_link(color) do
    GenServer.start_link(__MODULE__, color, name: __MODULE__)
  end

  def set(color) do
    GenServer.cast(__MODULE__, {:change_color, color})
  end

  def info do
    GenServer.cast(__MODULE__, :info)
  end

  @impl GenServer
  def init(color) do 
    IO.puts("Light turns #{color}")
    {:ok, color}
  end

  @impl GenServer
  def handle_cast({:change_color, color}, current_color) do
    if color != current_color, do: IO.puts("Ligth turns #{color}")
    {:noreply, color}
  end

  @impl GenServer
  def handle_cast(:info, current_color) do
    IO.puts("Ligth is #{current_color}")
    {:noreply, current_color}
  end
end

defmodule Lock do
  def init do
    Light.start_link(:red)
    :wait_for_first_1
  end

  def reinit do
    Light.set(:red)
    :wait_for_first_1
  end

  def accept("1", :wait_for_first_1), do: :wait_for_3
  def accept("3", :wait_for_3), do: :wait_for_last_1
  def accept("1", :wait_for_3), do: :wait_for_3
  def accept("1", :wait_for_last_1) do
    Light.set(:green)
    :unlocked
  end
  def accept("info", state) do
    Light.info()
    state
  end
  def accept("lock", :unlocked), do: reinit() 
  def accept(_, :unlocked), do: :unlocked
  def accept(_, _), do: reinit()

  def run do
    :stdio
    |> IO.stream(:line)
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(Lock.init, &Lock.accept/2)
  end
end

