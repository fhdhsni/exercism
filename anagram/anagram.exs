defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Stream.filter(&String.length(&1) == String.length(base)) # If they are not the same length they're not anagrams
    |> Stream.filter(&String.downcase(&1) != String.downcase(base)) # shouldn't be exactly the same word
    |> Enum.filter(&(sort(&1) == sort(base)))
  end
  
  def sort(word) do
    word
    |> String.downcase
    |> String.to_charlist
    |> Enum.sort
    |> List.to_string
  end
end
