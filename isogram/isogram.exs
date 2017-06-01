defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/\s|[^a-zA-Z]/, "")
    |> String.to_charlist
    |> is_it?
  end

  def is_it?(list) do
    init_size = length(list)
    after_size = list |> Enum.uniq |> length

    init_size === after_size
  end
end
