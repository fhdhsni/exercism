defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter | :saturn | :uranus | :neptune
  @earth 31557600
  @mercury  0.2408467 * @earth
  @venus  0.61519726 * @earth
  @mars  1.8808158 * @earth
  @jupiter  11.862615 * @earth
  @saturn  29.447498 * @earth
  @uranus  84.016846 * @earth
  @neptune  164.79132 * @earth
  
  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / how_much(planet)
  end
  
  defp how_much(planet) do
    case planet do
      :mercury -> @mercury
      :venus   -> @venus
      :earth   -> @earth
      :mars    -> @mars
      :jupiter -> @jupiter
      :saturn  -> @saturn
      :uranus  -> @uranus
      :neptune -> @neptune
    end
  end

end
