defmodule Fsrs.MemoryState do
  @moduledoc """
  Represents the memory state of an FSRS item.
  """
  @type t :: %__MODULE__{
          stability: float(),
          difficulty: float()
        }

  defstruct stability: 0.0,
            difficulty: 0.0
end
