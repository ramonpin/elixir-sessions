defmodule DataStructuresTest do
  use ExUnit.Case
  alias Session.One.DataStructures

  test "list_sample folds the list" do
    assert DataStructures.list_sample() == 6
  end

  test "list append" do
    l1 = [1, 2, 3]
    l2 = [4, 5]

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

  test "tuple sample" do
    assert DataStructures.tuple_sample() == {:sum, 1, 3}
  end

  test "map samples" do
    assert DataStructures.map_sample() == %{"x" => 0, "y" => 3, "z" => 3}
    assert DataStructures.map_sample_keywords() == %{x: 0, y: 3, z: 3}
    assert DataStructures.map_inplace_updates() == %{x: 0, y: 1, z: 2}

    m = %{a: 1, b: 2}
    assert Map.fetch(m, :a) == {:ok, 1}
    assert Map.fetch(m, :z) == :error
    assert Map.fetch!(m, :a) == 1
    # assert Map.fetch(m, :z) <<=== BREAKS 
    assert Map.get(m, :a, :unknown) == 1
    assert Map.get(m, :z, :unknown) == :unknown
  end

  test "vector length for multiple dimensions" do
    assert DataStructures.vector_length(%{x: 1, y: 2, z: 2}) == 3
    assert DataStructures.vector_length(%{x: 3, y: 4}) == 5
    assert DataStructures.vector_length(%{x: 3}) == 3

    assert DataStructures.vector_length(%{x: 1, y: 2, z: 2, c: 7}) == 3
    assert DataStructures.vector_length(%{x: 3, y: 4, c: 7}) == 5
    assert DataStructures.vector_length(%{x: 3, c: 7}) == 3
  end

  test "range samples" do
    assert DataStructures.range_sample() == 24
    assert Enum.to_list(2..10//2) == [2, 4, 6, 8, 10]

    assert Enum.member?(2..10//2, 4)
    refute Enum.member?(2..10//2, 1)
  end
end
