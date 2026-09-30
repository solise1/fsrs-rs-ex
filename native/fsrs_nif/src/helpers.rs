const SECS_PER_DAY: u32 = 86_400;

pub fn whole_days_between(timestamp1: u32, timestamp2: u32) -> u32 {
    (timestamp1 - timestamp2) / SECS_PER_DAY
}
