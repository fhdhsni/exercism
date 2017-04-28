defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..limit - 1
    |> Enum.to_list
    |> Enum.filter(&do_filter(&1, factors))
    |> Enum.sum
  end

  defp do_filter(num, factors) do
    factors
    |> Enum.any?(&rem(num, &1) == 0)
  end

end
