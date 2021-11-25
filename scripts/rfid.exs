defmodule RFID do
  @moduledoc """
  This the solution to advent_of_code_2020 day 25
  """

  @start_code 1
  @magic_number 20_201_227
  @initial_subject 7

  def loop(subject, loop_size),
    do: loop(@start_code, loop_size, subject)

  defp loop(num, 0, _subject_number),
    do: num

  defp loop(num, step, subject_number),
    do: loop(rem(num * subject_number, @magic_number), step - 1, subject_number)

  def discover_loop_size(key),
    do: discover_loop_size(key, 1, @start_code)

  defp discover_loop_size(key, n, m) do
    m = rem(m * @initial_subject, @magic_number)
    if m == key, do: n, else: discover_loop_size(key, n + 1, m)
  end

  def calculate_encription_key(device1, device2) do
    with [ok: loop_size1, ok: loop_size2] <-
           [device1, device2]
           |> Task.async_stream(&discover_loop_size/1)
           |> Enum.to_list(),
         [ok: enc_key1, ok: enc_key2] <-
           [{device1, loop_size2}, {device2, loop_size1}]
           |> Task.async_stream(fn {device, loop_size} -> loop(device, loop_size) end)
           |> Enum.to_list(),
         ^enc_key1 <- enc_key2 do
      {:ok, enc_key1}
    end
  end
end
