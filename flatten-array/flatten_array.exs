defmodule FlattenArray do
  @doc """
  Accept a list and return the list flattened without nil values.

  ## Examples

  iex> FlattenArray.flatten([1, [2], 3, nil])
  [1,2,3]

  iex> FlattenArray.flatten([nil, nil])
  []

  """

  @spec flatten(list) :: list
  def flatten(list)
  def flatten(list) do
    do_flatten(list)
    |> Enum.filter(fn nil -> false; _ -> true end)
    |> Enum.reverse
  end

  def do_flatten(l, acc \\ [])
  def do_flatten([], acc), do: acc
  def do_flatten([head | tail], acc) when is_list(head) do
    head
    |> Enum.reverse
    |> Enum.reduce(tail, fn x, accumulator -> [x | accumulator] end)
    |> do_flatten(acc)
  end
  def do_flatten([head | tail], acc), do: do_flatten(tail, [head | acc])

end
