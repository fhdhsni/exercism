defmodule Words do
  @spec count(String.t) :: map
  def count(str) do
    str
    |> String.downcase
    |> (&(Regex.replace(~r/[^\w\s_-]/u, &1, ""))).()
    |> String.replace("_", " ")
    |> String.split
    |> do_count
  end

  def do_count(list, acc \\ %{})
  def do_count([], acc), do: acc
  def do_count([first | rest], acc) do
    acc
    |> Map.update(first, 1, fn x -> x+1 end)
    |> (&do_count(rest, &1)).()
  end

end
