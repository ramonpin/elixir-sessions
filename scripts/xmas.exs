defmodule XMAS do
  @moduledoc """
  This the solution to advent_of_code_2020 day 9 
  """

  def run(file, step) do 
    file
    |> File.stream!()
    |> Stream.map(&Integer.parse/1)
    |> Stream.map(&elem(&1, 0))
    |> search_failure(step)
  end

  def search_failure(data, step) do
    data
    |> Stream.chunk_every(step + 1, 1, :discard)
    |> Stream.map(&valid/1)
    |> Stream.reject(fn {_num, valid} -> valid end)
    |> Enum.take(1)
  end

  def valid(list) do
    [num | previous] = Enum.reverse(list)
    {num, verify(num, previous)}
  end

  defp verify(_num, []),
    do: false

  defp verify(num, [head | tail]) do 
    case (num - head) in tail do
      true -> true
      false -> verify(num, tail)
    end
  end
end
