defmodule Bob do
  import String
  def hey(str) do
    cond do
      trim(str) == ""                            -> "Fine. Be that way!"
      ends_with?(str, "?")                       -> "Sure."
      upcase(str) == str && downcase(str) != str -> "Whoa, chill out!"
      true                                       -> "Whatever."
    end
  end
end
