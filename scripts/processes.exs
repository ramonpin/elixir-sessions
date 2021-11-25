defmodule Session.Trials.Processes do

  def start(a) when is_integer(a) do
    spawn(__MODULE__, :loop, [a, a])
  end

  def call(me, msg) do
    send(me, {:call, me, msg})
  end

  def loop(initial, current) do
    me = self()
    receive do
      {:call, ^me, msg} ->
        {:ok, new_current} = handle_msg(msg, initial, current)
        loop(initial, new_current)
    end
    loop(initial, current)
  end

  def handle_msg(:inc, _initial, current) do
    {:ok, current + 1}
  end

  def handle_msg(:dec, _initial, current) do
    {:ok, current - 1}
  end

  def handle_msg(:show, _initial, current) do
    IO.puts(current)
    {:ok, current}
  end

  def handle_msg(:reset, initial, _current) do
    {:ok, initial}
  end

end
