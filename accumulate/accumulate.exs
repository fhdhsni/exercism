defmodule Accumulate do
  def accumulate(list, fun, acc \\ [])
  def accumulate([], _fun, acc), do: Enum.reverse acc
  def accumulate([head | rest], fun, acc) do
    acc = [fun.(head) | acc]
    accumulate(rest, fun, acc)
  end
end
