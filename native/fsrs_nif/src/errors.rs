use fsrs::FSRSError;

pub struct ErrorWrapper(pub FSRSError);

impl From<FSRSError> for ErrorWrapper {
    fn from(e: FSRSError) -> Self {
        ErrorWrapper(e)
    }
}

impl From<ErrorWrapper> for rustler::Error {
    fn from(e: ErrorWrapper) -> Self {
        rustler::Error::Atom(fsrs_error_to_term(&e.0))
    }
}

fn fsrs_error_to_term(err: &FSRSError) -> &'static str {
    match err {
        FSRSError::NotEnoughData => "not_enough_data",
        FSRSError::Interrupted => "interrupted",
        FSRSError::InvalidParameters => "invalid_parameters",
        FSRSError::OptimalNotFound => "optimal_not_found",
        FSRSError::InvalidInput => "invalid_input",
        FSRSError::InvalidDeckSize => "invalid_deck_size",
    }
}
