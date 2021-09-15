defmodule DataStructuresTest do
  use ExUnit.Case
  alias Session.One.DataStructures

  test "list_sample folds the list" do
    assert DataStructures.list_sample() == 6 
  end

  test "list append" do
    l1 = [1, 2, 3] 
    l2 =[4, 5]

    assert l1 ++ l2 == [1, 2, 3, 4, 5] 
    assert l1 == [1, 2, 3]
    assert l2 == [4, 5]
  end

  test "list prepend" do
    l = [1, 2, 3]

    assert [:a | l] == [:a, 1, 2, 3]
    assert [:a, :b | l] == [:a, :b, 1, 2, 3]
    assert l == [1, 2, 3]
  end

  test "split_even_odd works for any integer list" do
    assert DataStructures.split_even_odd([1, 2, 3, 4]) == [1, 3, 2, 4]
    assert DataStructures.split_even_odd([1, 2, 3]) == [1, 3, 2]
    assert DataStructures.split_even_odd([1]) == [1]
    assert DataStructures.split_even_odd([]) == []
  end
end
