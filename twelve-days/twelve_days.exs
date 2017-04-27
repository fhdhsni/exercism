defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(n :: integer) :: String.t()
  def verse(1), do: create_initial_part(1) <> ", a Partridge in a Pear Tree."
  def verse(n) do
    create_initial_part(n) <> bullshit_up_to_day(n)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.to_list
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end

  def day_to_string(n) do
    case n do
      1  -> "first"
      2  -> "second"
      3  -> "third"
      4  -> "fourth"
      5  -> "fifth"
      6  -> "sixth"
      7  -> "seventh"
      8  -> "eighth"
      9  -> "ninth"
      10 -> "tenth"
      11 -> "eleventh"
      12 -> "twelfth"
    end
  end

  def create_initial_part(day) do
    "On the #{day_to_string(day)} day of Christmas my true love gave to me"
  end

  def bullshit_up_to_day(day, acc \\ "")
  def bullshit_up_to_day(0, acc), do: acc <> "."
  def bullshit_up_to_day(day, acc) do
    accumulated_bullshit = acc <> ", " <> corresponding_bullshit(day)
    bullshit_up_to_day(day - 1, accumulated_bullshit)
  end

  def corresponding_bullshit(day) do
    case day do
      1  -> "and a Partridge in a Pear Tree"
      2  -> "two Turtle Doves"
      3  -> "three French Hens"
      4  -> "four Calling Birds"
      5  -> "five Gold Rings"
      6  -> "six Geese-a-Laying"
      7  -> "seven Swans-a-Swimming"
      8  -> "eight Maids-a-Milking"
      9  -> "nine Ladies Dancing"
      10 ->  "ten Lords-a-Leaping"
      11 ->  "eleven Pipers Piping"
      12 ->  "twelve Drummers Drumming"
      end
    end
end
