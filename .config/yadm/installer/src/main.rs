use std::{
    error::Error,
    fs::File,
    io::{BufReader, BufWriter},
};

use clap::Parser;

mod app;
mod config;
mod ui;

use config::InstallTarget;

use crate::{
    app::Commands,
    config::{
        prelude::Service,
        system::{Backup, ConfigFile, Package, Repository},
        BuildTarget, AUR_HELPER, UPDATE_COMMAND,
    },
};

fn install_target(target: InstallTarget) {
    for command in target.to_string().lines() {
        let command_result = match app::check_output(command) {
            Ok(result) => result,
            Err(why) => {
                log::error!("Internally failed to run command: {}", command);

                panic!("{}", why)
            }
        };

        if command_result {
            log::debug!("Successfully ran command: {}", command);
        } else {
            log::error!(
                "Failed to run command, check output above!\ncommand: {}",
                command
            );

            panic!("Failed to run command");
        }
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    // General setup
    human_panic::setup_panic!();
    env_logger::init();

    // Parse command line arguments
    let args = app::Cli::parse();
    match args.subcommand {
        Commands::Install { target } => {
            install_target(
                match target
                    .map(|target_path| {
                        InstallTarget::new(
                            match serde_json::from_reader(BufReader::new(match File::open(target_path) {
                                Ok(file) => file,
                                Err(why) => {
                                    log::warn!(
                                        "Failed to open target file, falling back to interactive mode!\n{}",
                                        why
                                    );

                                    return ui::aquire_target();
                                }
                            })) {
                                Ok(target) => target,
                                Err(why) => {
                                    log::warn!(
                                        "Bad configuration detected, failed to parse!\n{}",
                                        why
                                    );

                                    return ui::aquire_target();
                                }
                            },)
                        .map_err(|why| why.into())
                    })
                    .transpose()?
                {
                    Some(install_target) => install_target,
                    None => {
                        log::error!("Failed to aquire installation_target, check previous output");
                        panic!()
                    }
                },
            );
        }
        Commands::Create { target } => {}
    }

    Ok(())
}
