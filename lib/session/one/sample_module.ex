defmodule Session.One.SampleModule do
  @moduledoc false

  @doc "Función pública"
  def calc(a, b) do
    a + b
  end

  @doc "Función con valores por defecto"
  def calc_defaulted(a, b \\ 2) do
    rem(a, b)
  end

  @doc "Función pública declarada en una línea"
  def calc_single_line(a, b), do: a - b

  # Función privada
  defp private_calc(a, b) do
    a * b
  end

  @doc "Invocación de función"
  def call_others(a, b) do
    calc(a, b) * 2 + calc_single_line(a, b) * private_calc(a, b)
  end

  @doc """
  Funciones complejas. Esta calcula el resultado de una ecuación cuadrática
  con coeficientes a, b, y c. Solo se evaluan los resultados en R.
  """
  def complex_fun(a, b, c) do
    coef = b * b - 4 * a * c

    case coef do
      0 ->
        -b / (2 * a)

      n when n > 0 ->
        sqr = :math.sqrt(coef)
        {(-b - sqr) / (2 * a), (-b + sqr) / (2 * a)}

      _ ->
        :complex_solution
    end
  end
end
