defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t

  def verse(0) do
  """
  No more bottles #{ on_the_wall() }, #{ bottle(0) } of beer.
  Go to the store and buy some more, #{ bottle(99) } #{ on_the_wall() }.
  """
  end

  def verse(1) do
  """
  #{ line1(1) }
  Take it down and pass it around, #{ bottle(0) } #{ on_the_wall() }.
  """
  end

  def verse(number) do
  """
  #{ line1(number) }
  #{ line2(number - 1) }
  """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  defp bottle(0), do: "no more bottles"
  defp bottle(1), do: "1 bottle"
  defp bottle(number) do
    "#{ number } bottles"
  end

  defp line2(number) do
    "Take one down and pass it around, #{ bottle(number) } #{ on_the_wall() }."
  end

  defp on_the_wall() do
    "of beer on the wall"
  end

  defp line1(number) do
    "#{ bottle(number) } #{ on_the_wall() }, #{ bottle(number) } of beer."
  end

end
