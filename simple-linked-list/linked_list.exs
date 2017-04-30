defmodule LinkedList do
  #################################################################################
  # Beautiful parts are stolen form exercism user @altmer http://exercism.io/altmer
  #################################################################################
  @opaque t :: map()
  @empty %{next: nil}
  @empty_error {:error, :empty_list}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: @empty

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    %{value: elem, next: list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list), do: do_length(list, 0)

  defp do_length(%{next: nil}, acc), do: acc
  defp do_length(%{value: _, next: list}, acc), do: do_length(list, acc + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(@empty), do: true
  def empty?(_), do: false
  
  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(@empty), do: @empty_error
  def peek(list), do: {:ok, list.value}
  
  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}

  def tail(@empty), do: @empty_error
  def tail(list), do: {:ok, list.next}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(@empty), do: @empty_error
  def pop(list) do
    with {:ok, tail} <- __MODULE__.tail(list),
         {:ok, head} <- __MODULE__.peek(list) do
      {:ok, head, tail}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse
    |> Enum.reduce(@empty, &__MODULE__.push(&2, &1))
  end
  
  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    with {:ok, tail} <- __MODULE__.tail(list),
         {:ok, head} <- __MODULE__.peek(list) do
      [head | to_list(tail)]
    else
      @empty_error -> []
    end
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list, acc \\ @empty)
  def reverse(@empty, acc), do: acc
  def reverse(list, acc) do
    {:ok, head, tail} = __MODULE__.pop(list)
    reverse(tail, %{value: head, next: acc})
  end
end
