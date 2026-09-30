use fsrs::{FSRS, FSRSItem, FSRSReview};

use crate::{
    errors::ErrorWrapper,
    helpers::whole_days_between,
    structs::{MemoryState, Review, TimestampedReview},
};

#[rustler::nif]
fn migrate_with_full_history_timestamped(
    timestamped_reviews: Vec<TimestampedReview>,
) -> Result<MemoryState, rustler::Error> {
    let fsrs = FSRS::default();
    let item = build_fsrs_item(timestamped_reviews);

    let memory_state = fsrs.memory_state(item, None).map_err(ErrorWrapper::from)?;

    Ok(memory_state.into())
}

#[rustler::nif]
fn migrate_with_full_history(reviews: Vec<Review>) -> Result<MemoryState, rustler::Error> {
    let fsrs = FSRS::default();
    let item = FSRSItem {
        reviews: reviews.into_iter().map(Into::into).collect(),
    };

    let memory_state = fsrs.memory_state(item, None).map_err(ErrorWrapper::from)?;

    Ok(memory_state.into())
}

#[rustler::nif]
fn migrate_with_partial_history(
    reviews: Vec<Review>,
    ease_factor: f32,
    first_interval: f32,
    sm2_retention: f32,
) -> Result<MemoryState, rustler::Error> {
    let fsrs = FSRS::default();
    let reviews: Vec<FSRSReview> = reviews.into_iter().map(Into::into).collect();
    let item = FSRSItem { reviews };

    // Calculate the earliest memory state
    let initial_state = fsrs
        .memory_state_from_sm2(ease_factor, first_interval, sm2_retention)
        .map_err(ErrorWrapper::from)?;

    // Calculate the current memory state, passing the initial state
    let memory_state = fsrs
        .memory_state(item, Some(initial_state))
        .map_err(ErrorWrapper::from)?;

    Ok(memory_state.into())
}

#[rustler::nif]
fn migrate_with_latest_state(
    ease_factor: f32,
    interval: f32,
    sm2_retention: f32,
) -> Result<MemoryState, rustler::Error> {
    let fsrs = FSRS::default();

    let memory_state = fsrs
        .memory_state_from_sm2(ease_factor, interval, sm2_retention)
        .map_err(ErrorWrapper::from)?;

    Ok(memory_state.into())
}

fn build_fsrs_item(history: Vec<TimestampedReview>) -> FSRSItem {
    let mut reviews = Vec::new();
    let mut current_date = history[0].timestamp;

    for r in history {
        let delta_t = whole_days_between(r.timestamp, current_date);
        reviews.push(FSRSReview {
            rating: r.rating,
            delta_t,
        });
        current_date = r.timestamp;
    }
    FSRSItem { reviews }
}
