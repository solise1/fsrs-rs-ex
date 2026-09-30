defmodule Fsrs.NextStates do
  @moduledoc """
  Contains the next possible ItemStates during a review.
  """
  alias Fsrs.ItemState

  @type t() :: %__MODULE__{
          again: ItemState.t(),
          hard: ItemState.t(),
          good: ItemState.t(),
          easy: ItemState.t()
        }

  defstruct again: %ItemState{},
            hard: %ItemState{},
            good: %ItemState{},
            easy: %ItemState{}
end
