use std::{
    error, fs,
    io::{stdout, Stdout},
    path::{self, Path, PathBuf},
};

use crossterm::terminal::enable_raw_mode;
use ratatui::{prelude::CrosstermBackend, Terminal};

use crate::{
    app,
    config::{
        system::{Backup, ConfigFile, Package},
        BuildTarget, InstallTarget,
    },
};

type Console = Terminal<CrosstermBackend<Stdout>>;

fn setup_terminal() -> Result<Console, Box<dyn error::Error>> {
    let mut terminal = Terminal::new(CrosstermBackend::new(stdout()))?;
    enable_raw_mode()?;

    terminal.clear();
    terminal.hide_cursor();

    Ok(terminal)
}

fn default_target(terminal: &Console) -> BuildTarget {
    let pacman_backup = "/etc/pacman.conf";

    let config_files = if pacman_backup.exists() {
        log::info!("Found previous backup for pacman.conf");

        ConfigFile::new(pacman_backup).backup()
    } else {
        log::debug!("Failed to find previous backup for pacman.conf");
    };

    BuildTarget {
        depends: vec!["system/pacman".to_string()],

        optional_repos: vec![],

        packages: vec![Package::system("base-devel")],
        config_files,
        services: vec![],

        commands: vec![],
    }
}

pub fn aquire_target() -> Result<InstallTarget, Box<dyn error::Error>> {
    const TARGET_PATH: &str = "primary.json";

    let terminal = setup_terminal()?;

    Ok(InstallTarget::new(default_target())?)
}
