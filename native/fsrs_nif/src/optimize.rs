use fsrs::{ComputeParametersInput, FSRSItem, FSRSReview, compute_parameters};

use crate::helpers::whole_days_between;
use crate::structs::Review;
use crate::{errors::ErrorWrapper, structs::TimestampedReview};

#[rustler::nif]
fn optimize_parameters(reviews: Vec<Vec<Review>>) -> Result<Vec<f32>, rustler::Error> {
    let fsrs_items: Vec<FSRSItem> = reviews
        .into_iter()
        .flat_map(convert_reviews_to_fsrs_item)
        .collect();

    let result = optimize_parameters_inner(fsrs_items)?;

    Ok(result)
}

#[rustler::nif]
fn optimize_parameters_timestamped(
    timestamped_reviews: Vec<Vec<TimestampedReview>>,
) -> Result<Vec<f32>, rustler::Error> {
    let fsrs_items: Vec<FSRSItem> = timestamped_reviews
        .into_iter()
        .flat_map(convert_timestamped_reviews_to_fsrs_item)
        .collect();

    let result = optimize_parameters_inner(fsrs_items)?;

    Ok(result)
}

fn optimize_parameters_inner(fsrs_items: Vec<FSRSItem>) -> Result<Vec<f32>, ErrorWrapper> {
    compute_parameters(ComputeParametersInput {
        train_set: fsrs_items,
        ..Default::default()
    })
    .map_err(Into::into)
}

fn convert_timestamped_reviews_to_fsrs_item(history: Vec<TimestampedReview>) -> Vec<FSRSItem> {
    let mut reviews = Vec::new();
    let mut current = history[0].timestamp;
    let mut items = Vec::new();

    for r in history {
        reviews.push(FSRSReview {
            rating: r.rating,
            delta_t: whole_days_between(r.timestamp, current),
        });
        items.push(FSRSItem {
            reviews: reviews.clone(),
        });
        current = r.timestamp;
    }

    items
        .into_iter()
        .filter(|item| item.long_term_review_cnt() > 0)
        .collect()
}

fn convert_reviews_to_fsrs_item(history: Vec<Review>) -> Vec<FSRSItem> {
    let mut reviews = Vec::new();
    let mut items = Vec::new();

    for r in history {
        reviews.push(r.into());
        items.push(FSRSItem {
            reviews: reviews.clone(),
        });
    }

    items
        .into_iter()
        .filter(|item| item.long_term_review_cnt() > 0)
        .collect()
}
