defmodule Session.One.ProcessChain do

  def counter(next_pid) do
    receive do
      n when is_integer(n) ->
        send next_pid, n + 1
    end
  end

  def create_process(n) do
    code_to_run = fn (_, send_to) ->
      spawn(ProcessChain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), code_to_run)

    send(last, 0)

    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    # :observer.start
    # :timer.sleep(5_000)

    :timer.tc(ProcessChain, :create_process, [n])
    |> IO.inspect
  end

end
