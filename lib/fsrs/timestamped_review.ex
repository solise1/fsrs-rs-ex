defmodule Fsrs.TimestampedReview do
  @moduledoc """
  Represents a review with a unix timestamp.

  A rating can be a number between 1-4, each representing:
  1-Again
  2-Hard
  3-Good
  4-Easy

  If you don't plan to persist the intervals between two reviews, prefer the functions that
  take timestamped reviews, as they'll calculate the intervals for you using NIFs.
  """
  @type t() :: %__MODULE__{
          rating: integer(),
          timestamp: integer()
        }

  defstruct rating: 1,
            timestamp: 0
end
