defmodule Session.One.Calc do
  def run(n) when is_number(n), do: n
  def run({:sum, a, b}), do: run(a) + run(b)
  def run({:prod, a, b}), do: run(a) * run(b)
  def run({:subs, a, b}), do: run(a) - run(b)
  def run({:div, a, b}), do: run(a) / run(b)
end
