# Adapted from https://github.com/open-spaced-repetition/fsrs-rs/blob/v6.6.2/examples/schedule.rs

defmodule ScheduleTest do
  alias Fsrs.MemoryState
  use ExUnit.Case

  test "schedule a new card" do
    next_states = Fsrs.Scheduler.schedule_new_card()

    assert(round_and_at_least_one(next_states.again.interval) == 1)
    assert(round_and_at_least_one(next_states.hard.interval) == 1)
    assert(round_and_at_least_one(next_states.good.interval) == 2)
    assert(round_and_at_least_one(next_states.easy.interval) == 8)
  end

  test "schedule an existing card" do
    memory_state = %MemoryState{
      stability: 7.0,
      difficulty: 5.0
    }

    interval = 7

    next_states = Fsrs.Scheduler.schedule_existing_card(memory_state, interval)

    assert(round_and_at_least_one(next_states.again.interval) == 1)
    assert(round_and_at_least_one(next_states.hard.interval) == 17)
    assert(round_and_at_least_one(next_states.good.interval) == 23)
    assert(round_and_at_least_one(next_states.easy.interval) == 38)
  end

  test "schedule an existing card using dates instead of interval" do
    memory_state = %MemoryState{
      stability: 7.0,
      difficulty: 5.0
    }

    last_review = DateTime.utc_now() |> DateTime.add(-7, :day) |> DateTime.to_unix()

    next_states =
      Fsrs.Scheduler.schedule_existing_card_from_timestamps(memory_state, last_review)

    assert(round_and_at_least_one(next_states.again.interval) == 1)
    assert(round_and_at_least_one(next_states.hard.interval) == 17)
    assert(round_and_at_least_one(next_states.good.interval) == 23)
    assert(round_and_at_least_one(next_states.easy.interval) == 38)
  end

  def round_and_at_least_one(n), do: round(n) |> max(1)
end
