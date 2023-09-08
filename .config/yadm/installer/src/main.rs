use std::error::Error;

mod config;

fn main() -> Result<(), Box<dyn Error>> {
    human_panic::setup_panic!();
    env_logger::init();

    Ok(())
}
