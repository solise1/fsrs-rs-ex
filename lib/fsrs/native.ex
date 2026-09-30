defmodule Fsrs.Native do
  @moduledoc """
  Rustler module that contains calls to NIFs.

  It's not meant to be used directly, as the parameters may change even in minor releases.

  If you're using this application as a dependency, use Fsrs.Optimizer, Fsrs.Scheduler and
  Fsrs.Migrate instead of this module.
  """
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :fsrs,
    crate: :fsrs_nif,
    base_url: "https://github.com/solise1/fsrs-rs-ex/releases/tag/v#{version}",
    nif_versions: ["2.15"],
    force_build: System.get_env("FSRS_RS_EX_BUILD") in ["1", "true"],
    version: version

  # ----- Schedule -----
  def next_states(_parameters, _desired_retention, _memory_state, _interval), do: error()

  def next_states_from_timestamps(
        _parameters,
        _desired_retention,
        _memory_state,
        _last_review,
        _due
      ),
      do: error()

  # ----- Optimize -----
  def optimize_parameters(_reviews), do: error()

  def optimize_parameters_timestamped(_timestamped_reviews), do: error()

  # ----- Migrate -----
  def migrate_with_full_history(_reviews), do: error()

  def migrate_with_full_history_timestamped(_reviews), do: error()

  def migrate_with_partial_history(
        _reviews,
        _ease_factor,
        _first_interval,
        _sm2_retention
      ),
      do: error()

  def migrate_with_latest_state(_ease_factor, _interval, _sm2_retention), do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
