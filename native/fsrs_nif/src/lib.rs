use rustler::{Env, Term};

mod errors;
mod helpers;
mod migrate;
mod optimize;
mod schedule;
mod structs;

fn load(_: Env, _: Term) -> bool {
    true
}

rustler::init!("Elixir.Fsrs.Native", load = load);
