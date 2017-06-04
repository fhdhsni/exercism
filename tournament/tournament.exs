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
    # input =
    # ["Allegoric Alaskans;Blithering Badgers;win",
    #  "Devastating Donkeys;Courageous Californians;draw",
    #  "Devastating Donkeys;Allegoric Alaskans;win",
    #  "Courageous Californians;Blithering Badgers;loss",
    #  "Blithering Badgers;Devastating Donkeys;loss",
    #  "Allegoric Alaskans;Courageous Californians;win"]
    matches =
      input
      |> Enum.filter(fn "" -> false; _ -> true end)
      |> Enum.filter(fn str -> Regex.match?(~r/(loss|win|draw)$/, str) end)
      |> Enum.filter(fn str -> !Regex.match?(~r/[^a-zA-Z\s\-;]/, str) end)
      |> Enum.map(&String.split(&1, ";"))
    # matches =
    # [["Allegoric Alaskans", "Blithering Badgers", "win"],
    #  ["Devastating Donkeys", "Courageous Californians", "draw"],
    #  ["Devastating Donkeys", "Allegoric Alaskans", "win"],
    #  ["Courageous Californians", "Blithering Badgers", "loss"],
    #  ["Blithering Badgers", "Devastating Donkeys", "loss"],
    #  ["Allegoric Alaskans", "Courageous Californians", "win"]]

    teams =
      matches
      |> find_team_names
      |> Enum.sort_by(fn team -> Map.get(team, :name) end)

    # teams =
    # [%{D: 0, L: 0, MP: 0, P: 0, W: 0, name: "Allegoric Alaskans"},
    #  %{D: 0, L: 0, MP: 0, P: 0, W: 0, name: "Blithering Badgers"},
    #  %{D: 0, L: 0, MP: 0, P: 0, W: 0, name: "Devastating Donkeys"},
    #  %{D: 0, L: 0, MP: 0, P: 0, W: 0, name: "Courageous Californians"}]

    result = Enum.reduce(matches, teams, &update_team_status(&1, &2))
    # result =
    # [%{D: 0, L: 1, MP: 3, P: 6, W: 2, name: "Allegoric Alaskans"},
    #  %{D: 0, L: 2, MP: 3, P: 1, W: 1, name: "Blithering Badgers"},
    #  %{D: 1, L: 0, MP: 3, P: 5, W: 2, name: "Devastating Donkeys"},
    #  %{D: 1, L: 2, MP: 3, P: 1, W: 0, name: "Courageous Californians"}]

    sort(result)
    |> print
    |> String.trim
    # |> IO.puts
  end

  def update_team_status([team1_name, team2_name, result_of_match], teams) do
    team1_index = Enum.find_index(teams, fn team -> Map.get(team, :name) == team1_name end)
    team2_index = Enum.find_index(teams, fn team -> Map.get(team, :name) == team2_name end)

    teams =
      case result_of_match do
        "win" ->
          teams = List.replace_at(teams, team1_index, Enum.at(teams, team1_index) |> Map.update!(:W, &(&1 + 1)))
          teams = List.replace_at(teams, team1_index, Enum.at(teams, team1_index) |> Map.update!(:P, &(&1 + 3)))
          List.replace_at(teams, team2_index, Enum.at(teams, team2_index) |> Map.update!(:L, &(&1 + 1)))
        "loss" ->
          teams = List.replace_at(teams, team1_index, Enum.at(teams, team1_index) |> Map.update!(:L, &(&1 + 1)))
          teams = List.replace_at(teams, team2_index, Enum.at(teams, team2_index) |> Map.update!(:W, &(&1 + 1)))
          List.replace_at(teams, team2_index, Enum.at(teams, team2_index) |> Map.update!(:P, &(&1 + 3)))
        "draw" ->
          teams = List.replace_at(teams, team1_index, Enum.at(teams, team1_index) |> Map.update!(:D, &(&1 + 1)))
          teams = List.replace_at(teams, team1_index, Enum.at(teams, team1_index) |> Map.update!(:P, &(&1 + 1)))
          teams = List.replace_at(teams, team2_index, Enum.at(teams, team2_index) |> Map.update!(:D, &(&1 + 1)))
          List.replace_at(teams, team2_index, Enum.at(teams, team2_index) |> Map.update!(:P, &(&1 + 1)))
      end

    teams = List.replace_at(teams, team1_index, Enum.at(teams, team1_index) |> Map.update!(:MP, &(&1 + 1)))
    List.replace_at(teams, team2_index, Enum.at(teams, team2_index) |> Map.update!(:MP, &(&1 + 1)))
  end

  def find_team_names(results) do
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

  def sort(result) do
    result
    |> Enum.sort_by(fn team -> Map.get(team, :P) end, &>=/2)
  end

  def print(result, acc \\ "")
  def print([], acc), do: acc
  def print(result, "") do
    header = first_column("Team") <> column("MP") <> column("W") <> column("D") <> column("L") <> column("P") <> "\n"
    header = String.trim(header)
    print(result, header <> "\n")    
  end

  def print([first | rest], acc) do
    name = Map.get(first, :name)
    mp = Map.get(first, :MP)
    w = Map.get(first, :W)
    d = Map.get(first, :D)
    l = Map.get(first, :L)
    p = Map.get(first, :P)
    acc = acc <> first_column(name) <> column(mp) <> column(w) <> column(d) <> column(l) <> column(p)
    acc = String.trim(acc)
    print(rest, acc <> "\n")
  end

  def first_column(str) do
    String.pad_trailing(str, 31)
  end
  def column(str) do
    "|" <> String.pad_leading(" #{str} ", 4)
  end

end
