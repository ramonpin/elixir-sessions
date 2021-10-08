defmodule Session.One.WithSample do
  defp op1(n) when is_number(n) and n >= 0, do: {:ok, n * (n - 1)}
  defp op1(any), do: {:error, "At op1 you must have a positive number but get #{inspect(any)}."}

  defp op2(number) when is_number(number), do: {:ok, number * 2}
  defp op2(any), do: {:error, "At op2 you must have a number but get #{inspect(any)}."}

  def combined_ops(n) do
    with {:ok, m} <- op2(n),
         {:ok, l} <- op1(m) do
      IO.puts("Success: #{l}")
    else
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end
end
