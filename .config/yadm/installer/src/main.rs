use std::{error::Error, fs::File, io::BufWriter, path::Path};

use crate::config::{
    system::{Backup, ConfigFile, Package, Repository},
    BuildTarget, InstallTarget,
};

mod app;
mod config;
mod ui;

fn main() -> Result<(), Box<dyn Error>> {
    human_panic::setup_panic!();
    env_logger::init();

    let target = BuildTarget {
        depends: vec![],

        optional_repos: vec![
            Repository::new("chaotic-aur")
                .bootstrap_command("sudo sed -i 's/#\\[multilib\\]/\\[multilib\\]/' /etc/pacman.conf".to_string())
                .bootstrap_command("sudo sed -i '/\\[multilib\\]/!b;n;cInclude = \\/etc\\/pacman.d\\/mirrorlist' /etc/pacman.conf".to_string())
        ],

        packages: vec![
            Package::system("base-devel")
                .with_depend(Package::system("base"))
                .with_depend(Package::system("git"))
        ],
        config_files: vec![
            ConfigFile::new("/etc/pacman.conf")
                .backup(Backup::move_to())
        ],
        services: vec![],

        commands: vec![],
    };

    let writer = BufWriter::new(File::create("test.json")?);
    serde_json::to_writer_pretty(writer, &target)?;

    let install_target = InstallTarget::new(target)?;

    println!("{}", install_target);

    Ok(())
}
