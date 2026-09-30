defmodule Fsrs.Optimizer do
  @moduledoc """
  Computes FSRS-6 parameters from a list of a list of reviews.

  Do note that FSRS models provide sensible default parameters that work well,
  this module simply allows you to optimize parameters for a specific person.

  The optimized parameters can be persisted and used later with Fsrs.Scheduler.
  """

  alias Fsrs.TimestampedReview
  alias Fsrs.Review
  alias Fsrs.Native

  @doc """
  Receives a list of a list of reviews with delta_t.

  Every internal list of reviews represents the review history of a specific card.
  """
  @spec optimize_parameters([[Review.t()]]) :: [float()]
  def optimize_parameters(list_of_lists_of_reviews) do
    Native.optimize_parameters(list_of_lists_of_reviews)
  end

  @doc """
  Receives a list of a list of timestamped reviews. Use this if you're not storing the interval between reviews.

  Every internal list of reviews represents the review history of a specific card.
  """
  @spec optimize_parameters_timestamped([[TimestampedReview.t()]]) :: [float()]
  def optimize_parameters_timestamped(list_of_lists_of_reviews) do
    Native.optimize_parameters_timestamped(list_of_lists_of_reviews)
  end
end
