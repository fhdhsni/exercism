defmodule Strain do
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun, acc \\ [])
  def keep([], _fun, acc), do: Enum.reverse acc
  def keep([h | rest], fun, acc) do
    result = fun.(h)

    if result do
      keep(rest, fun, [h | acc])
    else
      keep(rest, fun, acc)
    end
  end

  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    should_delete = keep(list, fun)
    delete_from_list(list, should_delete)
  end

  defp delete_from_list(list, []), do: list
  defp delete_from_list(list, [first | rest]) do
    List.delete(list, first)
    |> delete_from_list(rest)
  end
end
