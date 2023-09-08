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
        system::{Backup, Command, ConfigFile, Package, Repository},
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
                            match serde_json::from_reader(BufReader::new(File::open(target_path)?))
                            {
                                Ok(target) => target,
                                Err(why) => {
                                    log::warn!(
                                        "Bad configuration detected, failed to parse!\n{}",
                                        why
                                    );

                                    return ui::aquire_target();
                                }
                            },
                        )
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
        Commands::Create { target } => {
            serde_json::to_writer_pretty(
                BufWriter::new(File::create(target)?),
                &BuildTarget {
                    depends: vec![],

                    optional_repos: vec![
                        Repository::new("chaotic-aur")
                            .bootstrap_command(Command::pre_install("sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com"))
                            .bootstrap_command(Command::pre_install("sudo pacman-key --lsign-key 3056513887B78AEB"))
                            .bootstrap_command(Command::pre_install("sudo pacman -U --noconfirm --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'"))
                            .bootstrap_command(Command::pre_install("echo -e \"[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\" | sudo tee -a /etc/pacman.conf"))
                            .sort_command(),
                    ],
                    packages: vec![
                        Package::system("paru")
                            .post_install(Command::post_install()),
                        Package::system("asp"),
                        Package::system("bat"),
                        Package::system("devtools"),
                        Package::system("reflector"),
                        Package::system("rsync"),
                    ],
                    services: vec![],

                    commands: vec![
                        Command::pre_install("sudo sed -i 's/#Color/Color/' /etc/pacman.conf"),
                        Command::pre_install("sudo sed -i 's/#ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf"),
                        Command::pre_install("sudo git clone https://aur.archlinux.org/paru.git /tmp/dfm/paru"),
                        Command::pre_install("cd /tmp/dfm/paru && makepkg -si --noconfirm"),
                    ],
                }
            )?;
        }
    }

    Ok(())
}
