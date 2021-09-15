defmodule PatternMatchingTest do
  use ExUnit.Case
  import Session.One.PatternMatching

  test "fib works" do
    assert fib(0) == 1
    assert fib(1) == 1
    assert fib(20) == fib(19) + fib(18)
  end

  test "better_fib works even better" do
    assert better_fib(0) == 1
    assert better_fib(1) == 1
    assert better_fib(200) == better_fib(199) + better_fib(198)
  end

  test "handle simple ops" do
    assert handle_op({:sum, 1, 2}) == 3
    assert handle_op({:res, 1, 2}) == -1 
    assert handle_op({:neg, 4}) == -4
  end

  test "handle complex op" do
    assert handle_op({:sum, {:sum, 1, 2}, 3}) == 6
    assert handle_op({:sum, 3, {:sum, 1, 2}}) == 6 
    assert handle_op({:sum, {:neg, 4}, {:res, 6, 1}}) == 1 
    assert handle_op({:sum, {:neg, 4}, {:sum, 6, {:neg, 1}}}) == 1 
  end
end
