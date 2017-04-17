defmodule RotationalCipher do
  @n 26                         # number of letter in English
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> cipherizer(shift)
  end

  defp cipherizer(charlist, shift, acc \\ "")
  defp cipherizer([], _shift, acc), do: acc # we are done.

  defp cipherizer([char | rest], shift, acc) when (char >= ?a and char <= ?z) do # lowercase letters
    rotate_by = char + rem(shift, @n)
    ciphered_char = if(rotate_by > ?z, do: rotate_by - @n, else: rotate_by)
    
    cipherizer(rest, shift, acc <> << ciphered_char >>)
  end

  defp cipherizer([char | rest], shift, acc) when (char >= ?A and char <= ?Z) do # uppercase letters
    rotate_by = char + rem(shift, @n)
    ciphered_char = if(rotate_by > ?Z, do: rotate_by - @n, else: rotate_by)

    cipherizer(rest, shift, acc <> << ciphered_char >>)
  end

  defp cipherizer([char | rest], shift, acc), do: cipherizer(rest, shift, acc <> << char >>) # let it go
end
