defmodule EnumSampleTest do
  use ExUnit.Case
  import Session.One.EnumSamples

  test "enum samples" do
    assert enum_ops_pipelining() == 42
    assert_raise ArithmeticError, fn -> enum_ops_fail_pipelining() end
  end

  test "stream samples" do
    assert stream_ops_pipelining() == [0.5, 0.75] 
  end
end
