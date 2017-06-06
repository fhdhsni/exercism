defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l, acc \\ 0)
  def count([], acc), do: acc
  def count([_h | t], acc),  do: count(t, acc + 1)

  @spec reverse(list) :: list
  def reverse(l, reversed \\ [])
  def reverse([], reversed), do: reversed
  def reverse([h | t], reversed), do: reverse(t, [h | reversed])

  @spec map(list, (any -> any)) :: list
  def map(l, func, acc \\ [])
  def map([], _func, acc), do: reverse(acc)
  def map([h | t], func, acc), do: map(t, func, [func.(h) | acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, func, acc \\ [])
  def filter([], _func, acc), do: reverse(acc)
  def filter([h | t], func, acc) do
    func.(h)
    |> if(do: filter(t, func, [h | acc]),
      else: filter(t, func, acc))
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _func), do: acc
  def reduce([h | t], acc, func) do
    acc = func.(h, acc)
    reduce(t, acc, func)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a = reverse(a)
    b = reverse(b)

    do_append(a, b)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll = reverse(ll)
    reduce(ll, [], &concat_helper/2)
  end

  defp do_append(a, b, acc \\ [])
  defp do_append([], [], acc), do: acc
  defp do_append([h | t], [], acc) do
    do_append(t, [], [h | acc])
  end
  defp do_append(a, [h | t], acc) do
    do_append(a, t, [h | acc])
  end

  defp concat_helper(l, acc, reversed? \\ false)
  defp concat_helper([], acc, _reversed?), do: acc
  defp concat_helper(l, acc, false) do
    reverse(l)
    |> concat_helper(acc, true)
  end
  defp concat_helper([h | t], acc, true) do
    concat_helper(t, [h | acc], true)
  end
end
