defmodule AmigoInvisible do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def add(name, friend) do
    GenServer.cast(name, {:add, friend})
  end

  def select(name) do
    GenServer.call(name, :select)
  end

  def delete(name) do
    GenServer.stop(name)
  end

  @impl GenServer
  def init(:ok) do
    {:ok, %{friends: [], selections: nil}}
  end

  @impl GenServer
  def handle_cast({:add, new_friend}, %{friends: friends} = state) do
    {:noreply, %{state | friends: [new_friend | friends], selections: nil}}
  end

  @impl GenServer
  def handle_call(:select, _from, %{friends: friends, selections: selections} = state) do
    case selections do
      current_selections when is_list(current_selections) ->
        {:reply, current_selections, state}
      nil ->
        new_selections = friends_selection(friends)
        {:reply, new_selections, %{state | selections: new_selections}}
    end
  end

  defp friends_selection(list) do
    shuffled_list = Enum.shuffle(list)
    Enum.chunk_every(shuffled_list, 2, 1, shuffled_list)
  end
end
