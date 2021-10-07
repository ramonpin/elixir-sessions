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

  @doc "A simple tuple pipeline"
  def tuple_sample do
    {1, 2}
    |> Tuple.append(3)
    |> Tuple.delete_at(1)
    |> Tuple.insert_at(0, :sum)
  end

  @doc "A simple map sample"
  def map_sample do
    %{"x" => 1, "y" => 2}
    |> Map.put("z", 3)
    |> Map.replace("x", 0)
    |> Map.update("y", 0, &(&1 + 1))
  end

  @doc "A simple map sample with keywords"
  def map_sample_keywords do
    %{x: 1, y: 2}
    |> Map.put(:z, 3)
    |> Map.replace(:x, 0)
    |> Map.update(:y, 0, &(&1 + 1))
  end

  @doc "Map inplace updates"
  def map_inplace_updates do
    point = %{x: 0, y: 0, z: 0}
    %{point | y: 1, z: 2}
  end

  @doc "Pattern matching with maps"
  def vector_length(%{x: x, y: y, z: z}), do: :math.sqrt(x * x + y * y + z * z)
  def vector_length(%{y: y, x: x}), do: :math.sqrt(x * x + y * y)
  def vector_length(%{x: x}), do: x

  @doc "Presenting the Range"
  def range_sample do
    1..10
    |> Enum.filter(fn n -> rem(n, 2) == 0 end) 
    |> Enum.reject(fn n -> rem(n, 3) == 0 end)
    |> Enum.sum 
  end
end
