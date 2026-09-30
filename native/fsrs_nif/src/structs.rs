use fsrs::{
    FSRSReview, ItemState as FSRSItemState, MemoryState as FSRSMemoryState,
    NextStates as FSRSNextStates,
};
use rustler::NifStruct;

#[derive(NifStruct)]
#[module = "Fsrs.TimestampedReview"]
pub struct TimestampedReview {
    pub rating: u32,
    pub timestamp: u32,
}

#[derive(NifStruct)]
#[module = "Fsrs.Review"]
pub struct Review {
    pub rating: u32,
    pub delta_t: u32,
}

impl From<FSRSReview> for Review {
    fn from(fsrs_review: FSRSReview) -> Self {
        Self {
            rating: fsrs_review.rating,
            delta_t: fsrs_review.delta_t,
        }
    }
}

impl From<Review> for FSRSReview {
    fn from(review: Review) -> Self {
        Self {
            rating: review.rating,
            delta_t: review.delta_t,
        }
    }
}

#[derive(NifStruct)]
#[module = "Fsrs.MemoryState"]
pub struct MemoryState {
    pub stability: f32,
    pub difficulty: f32,
}

impl From<FSRSMemoryState> for MemoryState {
    fn from(fsrs_memory_state: FSRSMemoryState) -> Self {
        Self {
            stability: fsrs_memory_state.stability,
            difficulty: fsrs_memory_state.difficulty,
        }
    }
}

impl From<MemoryState> for FSRSMemoryState {
    fn from(memory_state: MemoryState) -> Self {
        Self {
            stability: memory_state.stability,
            difficulty: memory_state.difficulty,
        }
    }
}

#[derive(NifStruct)]
#[module = "Fsrs.ItemState"]
pub struct ItemState {
    pub memory_state: MemoryState,
    pub interval: f32,
}

impl From<FSRSItemState> for ItemState {
    fn from(fsrs_item_state: FSRSItemState) -> Self {
        Self {
            memory_state: fsrs_item_state.memory.into(),
            interval: fsrs_item_state.interval,
        }
    }
}

impl From<ItemState> for FSRSItemState {
    fn from(item_state: ItemState) -> Self {
        Self {
            memory: item_state.memory_state.into(),
            interval: item_state.interval,
        }
    }
}

#[derive(NifStruct)]
#[module = "Fsrs.NextStates"]
pub struct NextStates {
    pub again: ItemState,
    pub hard: ItemState,
    pub good: ItemState,
    pub easy: ItemState,
}

impl From<FSRSNextStates> for NextStates {
    fn from(fsrs_next_states: FSRSNextStates) -> Self {
        Self {
            again: fsrs_next_states.again.into(),
            hard: fsrs_next_states.hard.into(),
            good: fsrs_next_states.good.into(),
            easy: fsrs_next_states.easy.into(),
        }
    }
}

impl From<NextStates> for FSRSNextStates {
    fn from(next_states: NextStates) -> Self {
        Self {
            again: next_states.again.into(),
            hard: next_states.hard.into(),
            good: next_states.good.into(),
            easy: next_states.easy.into(),
        }
    }
}
