# Adapted from https://github.com/open-spaced-repetition/fsrs-rs/blob/v6.6.2/examples/migrate.rs

defmodule MigrateTest do
  alias Fsrs.MemoryState
  alias Fsrs.{TimestampedReview, Review}
  use ExUnit.Case

  test "migrates with full review history (intervals)" do
    reviews = [
      %Review{
        rating: 3,
        delta_t: 0
      },
      %Review{
        rating: 3,
        delta_t: 1
      },
      %Review{
        rating: 4,
        delta_t: 3
      },
      %Review{
        rating: 3,
        delta_t: 7
      }
    ]

    memory_state = Fsrs.Migrate.migrate_with_full_history(reviews)
    expected = %MemoryState{stability: 58.60692596435547, difficulty: 1.0}

    assert(memory_state == expected)
  end

  test "migrates with full review history (timestamped)" do
    reviews = [
      %TimestampedReview{
        rating: 3,
        timestamp: date_to_unix({2000, 1, 1})
      },
      %TimestampedReview{
        rating: 3,
        timestamp: date_to_unix({2000, 1, 2})
      },
      %TimestampedReview{
        rating: 4,
        timestamp: date_to_unix({2000, 1, 5})
      },
      %TimestampedReview{
        rating: 3,
        timestamp: date_to_unix({2000, 1, 12})
      }
    ]

    memory_state = Fsrs.Migrate.migrate_with_full_history_timestamped(reviews)
    expected = %MemoryState{stability: 58.60692596435547, difficulty: 1.0}

    assert(memory_state == expected)
  end

  test "migrates with partial history" do
    ease_factor = 2.0
    interval = 5.0

    reviews = [
      %Review{
        rating: 3,
        delta_t: 5
      },
      %Review{
        rating: 4,
        delta_t: 10
      },
      %Review{
        rating: 3,
        delta_t: 20
      }
    ]

    memory_state =
      Fsrs.Migrate.migrate_with_partial_history(
        reviews,
        ease_factor,
        interval
      )

    expected = %MemoryState{
      difficulty: 8.0509033203125,
      stability: 46.526161193847656
    }

    assert(memory_state == expected)
  end

  test "migrates with just last review" do
    ease_factor = 2.5
    interval = 10.0

    memory_state = Fsrs.Migrate.migrate_with_latest_state(ease_factor, interval)

    expected = %MemoryState{
      stability: 10.0,
      difficulty: 6.914056301116943
    }

    assert(memory_state == expected)
  end

  def date_to_unix({year, month, day}) do
    Date.new!(year, month, day) |> DateTime.new!(~T[00:00:00]) |> DateTime.to_unix()
  end
end
