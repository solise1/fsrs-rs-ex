defmodule Fsrs.Scheduler do
  @moduledoc """
  Allows you to schedule new or existing cards.

  All functions can optionally receive FSRS parameters and/or a custom desired_retention.
  """

  alias Fsrs.MemoryState
  alias Fsrs.NextStates
  alias Fsrs.Native

  @type option :: {:parameters, [float()]} | {:desired_retention, float()}
  @type options :: [option()]

  @default_options [parameters: [], desired_retention: 0.9]

  @doc """
  Schedules a new card. Can receive FSRS parameters and/or a custom desired_retention.
  """
  @spec schedule_new_card(options()) :: NextStates.t()
  def schedule_new_card(options \\ []) do
    [parameters: parameters, desired_retention: desired_retention] =
      Keyword.merge(@default_options, options)

    Native.next_states(parameters, desired_retention, nil, 0)
  end

  @doc """
  Schedules an existing card that's being reviewed.

  It receives a MemoryState, the interval between the last review and now (in whole days)
  and can optionally receive FSRS parameters and/or a custom desired_retention.
  """
  @spec schedule_existing_card(MemoryState.t(), integer(), options()) :: NextStates.t()
  def schedule_existing_card(memory_state, interval, options \\ []) do
    [parameters: parameters, desired_retention: desired_retention] =
      Keyword.merge(@default_options, options)

    Native.next_states(parameters, desired_retention, memory_state, interval)
  end

  @doc """
  Schedules an existing card that's being reviewed.

  It receives:
  - memory_state
  - last_review: unix timestamp in seconds of the last review
  - due: time of the current review (pass nil for now)

  """
  @spec schedule_existing_card_from_timestamps(
          MemoryState.t(),
          integer(),
          integer(),
          options()
        ) ::
          NextStates.t()
  def schedule_existing_card_from_timestamps(
        memory_state,
        last_review,
        due \\ System.os_time(:second),
        options \\ []
      ) do
    [parameters: parameters, desired_retention: desired_retention] =
      Keyword.merge(@default_options, options)

    Native.next_states_from_timestamps(
      parameters,
      desired_retention,
      memory_state,
      last_review,
      due
    )
  end
end
