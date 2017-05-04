defmodule Matrix do
  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: []
  def from_string(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(&Enum.map(&1, fn str -> String.to_integer(str) end))
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: []) :: String.t()
  def to_string(matrix) do
    matrix
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: []) :: list(list(integer))
  def rows(matrix), do: matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: [], index :: integer) :: list(integer)
  def row(matrix, index), do: Enum.at(matrix, index)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: [], index :: integer, acc :: list(integer)) :: list(list(integer))
  def columns(matrix, column_index \\ 0, acc \\ [])
  def columns(matrix, column_index, acc) when length(matrix) == column_index, do: Enum.reverse(acc)
  def columns(matrix, column_index, acc) do
    column =
      matrix
      |> Enum.map(&Enum.at(&1, column_index))
    columns(matrix, column_index + 1, [column | acc])
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: [], index :: integer) :: list(integer)
  def column(matrix, index) do
    columns(matrix)
    |> Enum.at(index)
  end
end
