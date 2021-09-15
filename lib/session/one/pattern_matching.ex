defmodule Session.One.PatternMatching do
  @moduledoc false

  @doc "Pattern matching en un argumento. No es la definición mejor es solo un ejemplo."
  def fib(0), do: 1
  def fib(1), do: 1
  def fib(n) when is_integer(n) and n >= 2, do: fib(n - 2) + fib(n - 1)

  @doc "Pattern matching en varios argumentos. Esta es mejor"
  def better_fib(n), do: better_fib(n, 1, 1)
  defp better_fib(0, a, _b), do: a
  defp better_fib(n, a, b) when is_integer(n), do: better_fib(n - 1, b, a + b)

  @doc "Desestructuración & pattern matching"
  def handle_op({:sum, a, b}) when is_number(a) and is_number(b), do: a + b
  def handle_op({:res, a, b}) when is_number(a) and is_number(b), do: a - b
  def handle_op({:neg, a}) when is_number(a), do: -a
  def handle_op(a) when is_number(a), do: a

  def handle_op({op, a, b}) when is_tuple(a) or is_tuple(b) do
    handle_op({op, handle_op(a), handle_op(b)})
  end

  def handle_op({op, a}) when is_tuple(a) do
    handle_op({op, handle_op(a)})
  end
end
