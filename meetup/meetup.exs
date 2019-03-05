defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @teenths [12, 13, 14, 15, 16, 17, 18, 19]

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    days = %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}
    weekday = days[weekday]
    order_of_occurrences = [:first, :second, :third, :fourth, :fifth]

    1..31
    |> Stream.map(&Date.new(year, month, &1))
    |> Stream.filter(&match?({:ok, _}, &1))
    |> Stream.map(fn {_, date} -> date end)
    |> Stream.filter(&(Date.day_of_week(&1) == weekday))
    |> Enum.reduce({%{}, order_of_occurrences}, &tag_occurrences_of_weekday/2)
    |> (fn {occurrences_of_weekday, _} -> {year, month, occurrences_of_weekday[schedule]} end).()
  end

  defp add_teenth(occurrences_of_weekday, day) when day in @teenths do
    Map.put(occurrences_of_weekday, :teenth, day)
  end

  defp add_teenth(occurrences_of_weekday, _), do: occurrences_of_weekday

  defp add_last(occurrences_of_weekday, nth, day) when nth == :fourth or nth == :fifth do
    Map.put(occurrences_of_weekday, :last, day)
  end

  defp add_last(occurrences_of_weekday, _, _), do: occurrences_of_weekday

  defp tag_occurrences_of_weekday(date, {occurrences_of_weekday, [nth | order_of_occurrences]}) do
    {_, _, day} = Date.to_erl(date)

    occurrences_of_weekday =
      occurrences_of_weekday
      |> Map.put(nth, day)
      |> add_teenth(day)
      |> add_last(nth, day)

    {occurrences_of_weekday, order_of_occurrences}
  end
end
