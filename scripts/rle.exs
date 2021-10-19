defmodule RLE do
  def enc(list), do: enc(list, [])

  defp enc([], rlc), do: rlc |> Enum.reverse
  defp enc([a, a | rest], rlc), do: enc([{a, 2} | rest], rlc)
  defp enc([{a, n}, a | rest], rlc), do: enc([{a, n + 1} | rest], rlc)
  defp enc([elem | rest], rlc), do: enc(rest, [elem | rlc])
end
