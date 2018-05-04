defmodule MatchStickFactory do
  @cap_big 50
  @cap_med 20
  @cap_small 5

  # book solution using repeated function calls.
  def boxes_one(matchsticks) do
    big_boxes = div(matchsticks, @size_big) remaining = rem(matchsticks, @size_big)
    medium_boxes = div(remaining, @size_medium)
    remaining = rem(remaining, @size_medium)
    small_boxes = div(remaining, @size_small)
    remaining = rem(remaining, @size_small)
    %{
      big: big_boxes,
      medium: medium_boxes,
      small: small_boxes, remaining_matchsticks: remaining
    }
  end

  # my solution using successive maps.
  def boxes(matches) do
    map = %{big: 0, medium: 0, remaining_matchsticks: 0, small: 0}
    map = %{map | big: div(matches, @cap_big)}
    remaining = rem(matches, @cap_big)
    map = %{map | medium: div(remaining, @cap_med)}
    remaining = rem(remaining, @cap_med)

    %{
      map
      | small: div(remaining, @cap_small),
        remaining_matchsticks: rem(remaining, @cap_small)
    }
  end
end
