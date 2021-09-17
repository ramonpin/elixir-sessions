defmodule Session.One.EnumSamples do
  @moduledoc false

  @doc "We can pipeline multiple operations with the same data easily"
  def enum_ops_pipelining do
    [1, 2, 3, 4, 5, 6]
    |> Enum.chunk_every(2, 2, [1])
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.reject(fn n -> n < 10 end)
    |> Enum.reduce(fn n, acc -> n + acc end)
  end

  @doc "Enum module is eager so fails even when not needed"
  def enum_ops_fail_pipelining do
    [1, 2, 3, 4, 5, 0]
    |> Enum.chunk_every(2, 2, [1])
    |> Enum.map(fn [a, b] -> a / b end)
    |> Enum.take(2)
  end

  @doc "Stream module is lazy so do not fails when not needed"
  def stream_ops_pipelining do
    [1, 2, 3, 4, 5, 0]
    |> Stream.chunk_every(2, 2, [1])
    |> Stream.map(fn [a, b] -> a / b end)
    |> Enum.take(2)
  end
end
