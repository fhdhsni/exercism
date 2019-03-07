defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search_helper(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search_helper(_numbers, _key, lower, upper) when upper - lower < 0 do
    :not_found
  end

  defp search_helper(numbers, key, lower, upper) do
    middle = div(lower + upper, 2)

    cond do
      elem(numbers, middle) > key ->
        search_helper(numbers, key, lower, middle - 1)

      elem(numbers, middle) < key ->
        search_helper(numbers, key, middle + 1, upper)

      elem(numbers, middle) == key ->
        {:ok, middle}
    end
  end
end
