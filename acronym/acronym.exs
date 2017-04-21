defmodule Acronym do
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(str) do
    str
    |> String.replace("-", " ")
    |> (&Regex.replace(~r/[A-Z]/, &1, fn x -> " #{x}" end)).()
    |> String.upcase
    |> String.split
    |> Enum.map(&String.first/1)
    |> List.to_string
  end
end
