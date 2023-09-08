use std::{
    error, fs,
    io::{stdout, Stdout},
    path::{self, Path, PathBuf},
    str::FromStr,
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

    let config_files = if Path::new(&format!("{}.bak", pacman_backup)).exists() {
        log::info!("Found previous backup for pacman.conf");

        vec![
            ConfigFile::new(pacman_backup).backup(Backup::Restore),
            ConfigFile::new("/etc/xdg/reflector/reflector.conf").backup(Backup::Restore),
        ]
    } else {
        log::debug!("Failed to find previous backup for pacman.conf");

        vec![]
    };

    BuildTarget {
        depends: vec!["system/cli".to_string()],

        optional_repos: vec![],

        packages: vec![Package::system("reflector"), Package::system("")],
        config_files,
        services: vec![],

        commands: vec![],
    }
}

pub fn aquire_target() -> Result<InstallTarget, Box<dyn error::Error>> {
    const TARGET_PATH: &str = "primary.json";

    let terminal = setup_terminal()?;

    Ok(InstallTarget::new(default_target(&terminal))?)
}
