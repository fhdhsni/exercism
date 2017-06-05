defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    matches =
      input
      |> Stream.filter(fn "" -> false; _ -> true end)
      |> Stream.filter(fn str -> Regex.match?(~r/(loss|win|draw)$/, str) end)
      |> Stream.filter(fn str -> !Regex.match?(~r/[^a-zA-Z\s\-;]/, str) end)
      |> Enum.map(&String.split(&1, ";"))

    teams =
      matches
      |> find_team_names
      |> Enum.sort_by(fn team -> Map.get(team, :name) end)

    matches
    |> Enum.reduce(teams, &update_team_status(&1, &2))
    |> sort
    |> print
    |> String.trim
    # |> IO.puts
  end

  defp update_team_status([team1_name, team2_name, result_of_match], teams) do
    team1_index = find_index(teams, team1_name)
    team2_index = find_index(teams, team2_name)

    teams =
      case result_of_match do
        "win" ->
          apply_result_effect(teams, team1_index, :W)
          |> apply_result_effect(team2_index, :L)

        "loss" ->
          apply_result_effect(teams, team1_index, :L)
          |> apply_result_effect(team2_index, :W)
        "draw" ->
          apply_result_effect(teams, team1_index, :D)
          |> apply_result_effect(team2_index, :D)
      end

    apply_result_effect(teams, team1_index, :MP)
    |> apply_result_effect(team2_index, :MP)
  end

  defp find_team_names(results) do
    results
    |> List.flatten
    |> Enum.uniq
    |> Enum.filter(fn
      "draw" -> false;
      "win"  -> false;
      "loss" -> false;
      _      -> true end)
      |> Enum.map(fn(team) -> %{D: 0, L: 0, MP: 0, P: 0, W: 0, name: team} end)
  end

  defp sort(result) do
    result
    |> Enum.sort_by(fn team -> Map.get(team, :P) end, &>=/2)
  end

  defp print(result, acc \\ "")
  defp print([], acc), do: acc
  defp print(result, "") do
    header = first_column("Team")
    <> column("MP")
    <> column("W")
    <> column("D")
    <> column("L")
    <> column("P")
    |> String.trim

    print(result, header <> "\n")
  end

  defp print([first | rest], acc) do
    name = first[:name]
    mp = first[:MP]
    w = first[:W]
    d = first[:D]
    l = first[:L]
    p = first[:P]

    acc = acc
    <> first_column(name)
    <> column(mp)
    <> column(w)
    <> column(d)
    <> column(l)
    <> column(p)
    |> String.trim
    print(rest, acc <> "\n")
  end

  defp first_column(str) do
    String.pad_trailing(str, 31)
  end

  defp column(str) do
    "|" <> String.pad_leading(" #{str} ", 4)
  end

  defp find_index(teams, team_name),
    do: Enum.find_index(teams, fn team -> team[:name] == team_name end)

  defp apply_result_effect(teams, team_index, :MP) do
    team = Enum.at(teams, team_index)
    team = %{team | MP: team[:MP] + 1}
    List.replace_at(teams, team_index, team)
  end
  
  defp apply_result_effect(teams, team_index, :L) do
    team = Enum.at(teams, team_index)
    team = %{team | L: team[:L] + 1}
    List.replace_at(teams, team_index, team)
  end

  defp apply_result_effect(teams, team_index, :W) do
    team = Enum.at(teams, team_index)
    team = %{team | W: team[:W] + 1, P: team[:P] + 3}
    List.replace_at(teams, team_index, team)
  end

  defp apply_result_effect(teams, team_index, :D) do
    team = Enum.at(teams, team_index)
    team = %{team | D: team[:D] + 1, P: team[:P] + 1}
    List.replace_at(teams, team_index, team)
  end

end
