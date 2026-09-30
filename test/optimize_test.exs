# Adapted from https://github.com/open-spaced-repetition/fsrs-rs/blob/v6.6.2/examples/optimize.rs

defmodule OptimizeTest do
  alias Fsrs.TimestampedReview
  alias Fsrs.Review
  use ExUnit.Case

  test "it optimizes parameters for a simulated review history (with intervals)" do
    reviews = create_reviews_for_cards()
    parameters = Fsrs.Optimizer.optimize_parameters(reviews)

    expected_parameters = [
      0.08642714470624924,
      5.396093845367432,
      7.490484714508057,
      13.714923858642578,
      6.323732376098633,
      0.9448277354240417,
      2.934157609939575,
      0.09567262977361679,
      1.9837696552276611,
      0.21434776484966278,
      0.9048716425895691,
      1.5262314081192017,
      0.0663452297449112,
      0.328567773103714,
      1.7279967069625854,
      0.6294882297515869,
      1.9866544008255005,
      0.5297254323959351,
      0.09359856694936752,
      0.11620604991912842,
      0.11389370262622833
    ]

    assert(parameters == expected_parameters)
  end

  test "it optimizes parameters for a simulated review history (timestamped)" do
    reviews = create_timestamped_reviews_for_cards()
    parameters = Fsrs.Optimizer.optimize_parameters_timestamped(reviews)

    expected_parameters = [
      0.08642714470624924,
      5.396093845367432,
      7.490484714508057,
      13.714923858642578,
      6.323732376098633,
      0.9448277354240417,
      2.934157609939575,
      0.09567262977361679,
      1.9837696552276611,
      0.21434776484966278,
      0.9048716425895691,
      1.5262314081192017,
      0.0663452297449112,
      0.328567773103714,
      1.7279967069625854,
      0.6294882297515869,
      1.9866544008255005,
      0.5297254323959351,
      0.09359856694936752,
      0.11620604991912842,
      0.11389370262622833
    ]

    assert(parameters == expected_parameters)
  end

  defp create_timestamped_reviews_for_cards() do
    [
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 5}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 15}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 20}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 2},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 4}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 12}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 28}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 15}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 5}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 8}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 24}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 10}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 1}), rating: 3}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 1},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 1},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 3}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 6}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 16}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 20}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 3}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 8}), rating: 2},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 10}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 22}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 5}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 25}), rating: 3}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 9}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 19}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 5}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 25}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 2},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 5}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 15}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 30}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 15}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 5}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 4}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 14}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 20}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 1},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 1},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 3}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 7}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 15}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 31}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 15}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 5}), rating: 3}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 10}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 20}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 5}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 25}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 15}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 1},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 2}), rating: 2},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 3}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 4}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 10}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 20}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 5}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 25}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 5}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 15}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 30}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 15}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 5}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 2},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 3}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 7}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 17}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 1}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 20}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 10}), rating: 4}
      ],
      [
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 1}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 12}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 1, 25}), rating: 4},
        %TimestampedReview{timestamp: date_to_unix({2023, 2, 10}), rating: 3},
        %TimestampedReview{timestamp: date_to_unix({2023, 3, 1}), rating: 4}
      ]
    ]
    |> Stream.cycle()
    |> Stream.take(100)
    |> Enum.to_list()
  end

  defp date_to_unix({year, month, day}) do
    Date.new!(year, month, day) |> DateTime.new!(~T[00:00:00]) |> DateTime.to_unix()
  end

  defp create_reviews_for_cards() do
    [
      [
        %Review{delta_t: 0, rating: 3},
        %Review{delta_t: 1, rating: 4},
        %Review{delta_t: 3, rating: 3},
        %Review{delta_t: 10, rating: 4},
        %Review{delta_t: 17, rating: 3},
        %Review{delta_t: 19, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 2},
        %Review{delta_t: 1, rating: 3},
        %Review{delta_t: 2, rating: 4},
        %Review{delta_t: 8, rating: 3},
        %Review{delta_t: 16, rating: 4},
        %Review{delta_t: 18, rating: 3},
        %Review{delta_t: 18, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 4},
        %Review{delta_t: 7, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 17, rating: 4},
        %Review{delta_t: 19, rating: 3}
      ],
      [
        %Review{delta_t: 0, rating: 1},
        %Review{delta_t: 1, rating: 1},
        %Review{delta_t: 1, rating: 3},
        %Review{delta_t: 3, rating: 4},
        %Review{delta_t: 10, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 19, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 3},
        %Review{delta_t: 2, rating: 3},
        %Review{delta_t: 5, rating: 2},
        %Review{delta_t: 2, rating: 4},
        %Review{delta_t: 12, rating: 3},
        %Review{delta_t: 14, rating: 4},
        %Review{delta_t: 20, rating: 3}
      ],
      [
        %Review{delta_t: 0, rating: 4},
        %Review{delta_t: 8, rating: 3},
        %Review{delta_t: 10, rating: 4},
        %Review{delta_t: 17, rating: 3},
        %Review{delta_t: 20, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 2},
        %Review{delta_t: 1, rating: 3},
        %Review{delta_t: 3, rating: 4},
        %Review{delta_t: 10, rating: 3},
        %Review{delta_t: 15, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 18, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 3},
        %Review{delta_t: 3, rating: 4},
        %Review{delta_t: 10, rating: 4},
        %Review{delta_t: 18, rating: 3},
        %Review{delta_t: 19, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 1},
        %Review{delta_t: 0, rating: 3},
        %Review{delta_t: 1, rating: 1},
        %Review{delta_t: 0, rating: 3},
        %Review{delta_t: 1, rating: 3},
        %Review{delta_t: 4, rating: 3},
        %Review{delta_t: 8, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 15, rating: 4},
        %Review{delta_t: 18, rating: 3}
      ],
      [
        %Review{delta_t: 0, rating: 4},
        %Review{delta_t: 9, rating: 3},
        %Review{delta_t: 10, rating: 4},
        %Review{delta_t: 16, rating: 4},
        %Review{delta_t: 20, rating: 3},
        %Review{delta_t: 18, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 1},
        %Review{delta_t: 1, rating: 2},
        %Review{delta_t: 1, rating: 3},
        %Review{delta_t: 1, rating: 4},
        %Review{delta_t: 6, rating: 3},
        %Review{delta_t: 10, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 20, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 3},
        %Review{delta_t: 4, rating: 4},
        %Review{delta_t: 10, rating: 3},
        %Review{delta_t: 15, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 18, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 2},
        %Review{delta_t: 2, rating: 3},
        %Review{delta_t: 4, rating: 4},
        %Review{delta_t: 10, rating: 3},
        %Review{delta_t: 15, rating: 4},
        %Review{delta_t: 19, rating: 3},
        %Review{delta_t: 18, rating: 4}
      ],
      [
        %Review{delta_t: 0, rating: 4},
        %Review{delta_t: 11, rating: 3},
        %Review{delta_t: 13, rating: 4},
        %Review{delta_t: 16, rating: 3},
        %Review{delta_t: 19, rating: 4}
      ]
    ]
    |> Stream.cycle()
    |> Stream.take(100)
    |> Enum.to_list()
  end
end
