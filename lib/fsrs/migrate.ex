defmodule Fsrs.Migrate do
  @moduledoc """
  Migrates from SM-2 (Anki's algorithm) to FSRS-6.

  If you started out with an FSRS model you can ignore this module.
  """
  alias Fsrs.Review
  alias Fsrs.TimestampedReview
  alias Fsrs.MemoryState
  alias Fsrs.Native

  @spec migrate_with_full_history([Review.t()]) :: MemoryState.t() | {:error, atom()}
  def migrate_with_full_history(reviews) do
    Native.migrate_with_full_history(reviews)
  end

  @spec migrate_with_full_history_timestamped([TimestampedReview.t()]) ::
          MemoryState.t() | {:error, atom()}
  def migrate_with_full_history_timestamped(timestamped_reviews) do
    Native.migrate_with_full_history_timestamped(timestamped_reviews)
  end

  @spec migrate_with_partial_history([Review.t()], float(), float(), float()) ::
          MemoryState.t() | {:error, atom()}
  def migrate_with_partial_history(
        reviews,
        ease_factor,
        first_interval,
        sm2_retention \\ 0.9
      ) do
    Native.migrate_with_partial_history(
      reviews,
      ease_factor,
      first_interval,
      sm2_retention
    )
  end

  @spec migrate_with_latest_state(float(), float(), float()) :: MemoryState.t() | {:error, atom()}
  def migrate_with_latest_state(ease_factor, interval, sm2_retention \\ 0.9) do
    Native.migrate_with_latest_state(ease_factor, interval, sm2_retention)
  end
end
