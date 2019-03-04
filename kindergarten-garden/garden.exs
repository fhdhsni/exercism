defmodule Garden do
  @default_names [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @plants %{"G" => :grass, "C" => :clover, "R" => :radishes, "V" => :violets}

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    student_names = Enum.sort(student_names)

    String.split(info_string, "\n")
    |> Stream.map(&split_into_two_chars/1)
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&flatten_list_of_strs/1)
    |> Stream.map(&unabbreviation_plant_name/1)
    |> Stream.map(&List.to_tuple/1)
    |> (fn plants -> give_plants_to_students(student_names, plants) end).()
    |> Enum.into(get_students_map(student_names))
  end

  defp split_into_two_chars(str) do
    String.split(str, ~r{..}, include_captures: true, trim: true)
  end

  defp flatten_list_of_strs(list_of_strs) do
    Enum.flat_map(list_of_strs, &String.split(&1, "", trim: true))
  end

  defp unabbreviation_plant_name(list_of_abbrev) do
    Enum.map(list_of_abbrev, &@plants[&1])
  end

  defp give_plants_to_students(student_names, plants) do
    Stream.zip(student_names, plants)
  end

  defp get_students_map(student_names) do
    Enum.into(student_names, %{}, &{&1, {}})
  end
end
