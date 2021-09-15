defmodule SampleModuleTest do
  use ExUnit.Case
  alias Session.One.SampleModule

  test "calc sums its arguments" do
    assert SampleModule.calc(1, 2) == 3
    assert SampleModule.calc(2, 2) == 4
  end

  test "calc_defaulted calculates reminder" do
    assert SampleModule.calc_defaulted(2, 2) == 0
    assert SampleModule.calc_defaulted(6, 3) == 0
    assert SampleModule.calc_defaulted(6, 4) == 2
  end

  test "calc_defaulted defaults divisor to 2" do
    assert SampleModule.calc_defaulted(2) == 0
    assert SampleModule.calc_defaulted(6) == 0
    assert SampleModule.calc_defaulted(5) == 1
  end

  test "complex_fun calculates solutions to ax^2 + bx + c = 0" do
    assert SampleModule.complex_fun(1, 0, -4) == {-2.0, 2.0}
    assert SampleModule.complex_fun(1, 2, 1) == -1.0 
    assert SampleModule.complex_fun(1, 0, 4) == :complex_solution
  end 
end
