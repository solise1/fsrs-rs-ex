use crate::{errors::ErrorWrapper, helpers::whole_days_between};
use fsrs::FSRS;

use crate::structs::{MemoryState, NextStates};

#[rustler::nif]
fn next_states_from_timestamps(
    parameters: Vec<f32>,
    desired_retention: f32,
    memory_state: Option<MemoryState>,
    last_review: u32,
    due: u32,
) -> Result<NextStates, rustler::Error> {
    let interval = whole_days_between(due, last_review);

    next_states_inner(parameters, desired_retention, memory_state, interval).map_err(Into::into)
}

#[rustler::nif]
fn next_states(
    parameters: Vec<f32>,
    desired_retention: f32,
    memory_state: Option<MemoryState>,
    interval: u32,
) -> Result<NextStates, rustler::Error> {
    next_states_inner(parameters, desired_retention, memory_state, interval).map_err(Into::into)
}

fn next_states_inner(
    parameters: Vec<f32>,
    desired_retention: f32,
    memory_state: Option<MemoryState>,
    interval: u32,
) -> Result<NextStates, ErrorWrapper> {
    let fsrs_memory_state = if memory_state.is_some() {
        Some(memory_state.unwrap().into())
    } else {
        None
    };

    let fsrs = FSRS::new(&parameters)?;

    let next_states = fsrs.next_states(fsrs_memory_state, desired_retention, interval)?;

    Ok(next_states.into())
}
