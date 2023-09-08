use std::{error::Error, fs::File, io::BufWriter};

use clap::Parser;

use crate::{
    app::Commands,
    config::{
        system::{Backup, ConfigFile, Package, Repository},
        BuildTarget, InstallTarget,
    },
};

mod app;
mod config;
mod ui;

fn main() -> Result<(), Box<dyn Error>> {
    // General setup
    human_panic::setup_panic!();
    env_logger::init();

    // Parse command line arguments
    let args = app::Cli::parse();
    match args.subcommand {
        Commands::Install { target } => {
            if let Some(target) = target {
            } else {
                // spawn user interface to get target config
            }
        }
    }

    Ok(())
}
