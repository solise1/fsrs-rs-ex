defmodule Fsrs.Review do
  @moduledoc """
  Represents a review without a timestamp, but rather a delta_t.

  delta_t is the difference between the current review and the previous one, in whole days.
  The first review of an item should have a delta_t of 0.

  A rating can be a number between 1-4, each representing:
  1-Again
  2-Hard
  3-Good
  4-Easy

  If you don't plan to persist the intervals between two reviews, prefer the functions that
  take timestamped reviews, as they'll calculate the intervals for you using NIFs.
  """
  @type t :: %__MODULE__{
          rating: integer(),
          delta_t: integer()
        }

  defstruct rating: 1,
            delta_t: 0
end
