defmodule Fsrs.MixProject do
  use Mix.Project

  @version "0.2.2"
  @source_url "https://github.com/solise1/fsrs-rs-ex"

  def project do
    [
      app: :fsrs,
      version: @version,
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      source_url: @source_url,
      name: "Fsrs",
      docs: &docs/0
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "FSRS is a modern spaced repetition algorithm that lets you schedule and optimize reviews. Fsrs provides Elixir bindings for fsrs-rs, a Rust implementation of FSRS."
  end

  defp deps do
    [
      {:rustler_precompiled, "~> 0.9.0"},
      {:rustler, "~> 0.38.0", optional: true},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true}
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native/fsrs_nif/.cargo",
        "native/fsrs_nif/src",
        "native/fsrs_nif/Cargo*",
        "checksum-*.exs",
        "mix.exs",
        "README.md"
      ],
      licenses: ["BSD-3-Clause"],
      links: %{"GitHub" => "https://github.com/solise1/fsrs-rs-ex"}
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      groups_for_modules: [
        Structs: [
          Fsrs.ItemState,
          Fsrs.MemoryState,
          Fsrs.NextStates,
          Fsrs.Review,
          Fsrs.TimestampedReview
        ]
      ]
    ]
  end
end
