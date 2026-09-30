defmodule Fsrs.ItemState do
  @moduledoc """
  An ItemState contains the MemoryState and the interval, in whole days, for when to review it next.
  """
  alias Fsrs.MemoryState

  @type t :: %__MODULE__{
          interval: float(),
          memory_state: MemoryState.t()
        }

  defstruct interval: 0.0,
            memory_state: %MemoryState{}
end
