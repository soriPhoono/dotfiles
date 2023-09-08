use std::{
    error,
    fs::{self, File},
    io::{self, stdout, BufReader, Stdout},
    path::{self, Path, PathBuf},
    str::FromStr,
};

use crossterm::terminal::enable_raw_mode;
use ratatui::{prelude::CrosstermBackend, Terminal};

use crate::{
    app,
    config::{
        system::{Backup, ConfigFile, Package},
        BuildTarget, InstallTarget, HOME,
    },
};

type Console = Terminal<CrosstermBackend<Stdout>>;

fn setup_terminal() -> Result<Console, io::Error> {
    let mut terminal = Terminal::new(CrosstermBackend::new(stdout()))?;
    enable_raw_mode()?;

    terminal.clear()?;
    terminal.hide_cursor()?;

    Ok(terminal)
}

fn default_target(terminal: &Console) -> BuildTarget {
    match serde_json::from_reader(BufReader::new(
        match File::open(&format!("{}/.config/yadm/targets/primary.json", HOME)) {
            Ok(file) => file,
            Err(why) => {
                log::error!("Failed to open primary target file: {}", why);

                panic!("Failed to open primary target file, check logs above! Run yadm restore to fix this issue.");
            }
        },
    )) {
        Ok(target) => target,
        Err(why) => {
            log::error!("Failed to parse primary target file: {}", why);

            panic!("Failed to parse primary target file, check logs above! Run yadm restore to fix this issue.");
        }
    }
}

pub fn aquire_target() -> Result<InstallTarget, Box<dyn error::Error>> {
    let terminal = setup_terminal()?;

    Ok(InstallTarget::new(default_target(&terminal))?)
}
