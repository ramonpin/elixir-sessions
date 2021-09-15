defmodule Session.One.DataStructures do
  @moduledoc false

  @doc "Simple usage of the List module"
  def list_sample do
    [1, 2, 3]
    |> List.foldl(0, fn e, acc -> e + acc end)
  end

  @doc "List pattern matching"
  def split_even_odd(list, even \\ [], odd \\ [])
  def split_even_odd([head | rest], even, odd) do
    case rem(head, 2) do
      0 -> split_even_odd(rest, [head | even], odd)
      1 -> split_even_odd(rest, even, [head | odd])
    end
  end
  def split_even_odd([], even, odd), do: Enum.reverse(even ++ odd)
end
