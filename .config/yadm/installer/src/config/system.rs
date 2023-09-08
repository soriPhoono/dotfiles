use std::{
    env::consts,
    fmt::{self, Display, Formatter},
    path::{Path, PathBuf},
};

use super::HOME;

pub mod prelude {
    pub use super::*;
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Repository {
    name: String,

    bootstrap_commands: Vec<String>,
}

impl Repository {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),

            bootstrap_commands: Vec::new(),
        }
    }

    pub fn bootstrap_command(mut self, command: String) -> Self {
        self.bootstrap_commands.push(command);

        self
    }
}

impl Display for Repository {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        if !self.bootstrap_commands.is_empty() {
            for command in &self.bootstrap_commands {
                writeln!(f, "{}", command)?;
            }
        } else {
            log::warn!("Repository {} has no bootstrap commands", self.name);
        }

        Ok(())
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum Package {
    System(String),
    Archive(String),
}

impl Package {
    pub fn system(name: &str) -> Self {
        Self::System(name.to_string())
    }

    pub fn archive(name: &str) -> Self {
        Self::Archive(name.to_string())
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Service {
    user: bool,

    name: String,

    start: bool,
    enable: bool,
}

impl Service {
    pub fn system(service_name: &str) -> Self {
        Self {
            user: false,

            name: service_name.to_string(),

            start: false,
            enable: false,
        }
    }

    pub fn user(service_name: &str) -> Self {
        Self {
            user: true,

            name: service_name.to_string(),

            start: false,
            enable: false,
        }
    }

    pub fn start(mut self) -> Self {
        self.start = true;

        self
    }

    pub fn enable(mut self) -> Self {
        self.enable = true;

        self
    }
}

impl Display for Service {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        if self.user {
            if self.enable && self.start {
                write!(f, "systemctl --user enable --now {}", self.name)
            } else if self.enable {
                write!(f, "systemctl --user enable {}", self.name)
            } else if self.start {
                write!(f, "systemctl --user start {}", self.name)
            } else {
                log::debug!("System service queried for command, but not setup to produce any");

                Ok(())
            }
        } else {
            if self.enable && self.start {
                write!(f, "sudo systemctl enable --now {}", self.name)
            } else if self.enable {
                write!(f, "sudo systemctl enable {}", self.name)
            } else if self.start {
                write!(f, "sudo systemctl start {}", self.name)
            } else {
                log::debug!("System service queried for command, but not setup to produce any");

                Ok(())
            }
        }
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum Backup {
    None,
    Copy(PathBuf),
    Move(PathBuf),
}

impl Backup {
    pub fn none() -> Self {
        Self::None
    }

    pub fn copy(backup_path: PathBuf) -> Self {
        Self::Copy(backup_path)
    }

    pub fn move_to(backup_path: PathBuf) -> Self {
        Self::Move(backup_path)
    }
}

impl Display for Backup {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Self::None => write!(f, "true"),
            Self::Copy(backup_path) => {
                if backup_path.starts_with(HOME) {
                    if backup_path.is_dir() {
                        write!(f, "cp -r {} {}", self, backup_path.display())
                    } else {
                        write!(f, "cp {} {}", self, backup_path.display())
                    }
                } else {
                    if backup_path.is_dir() {
                        write!(f, "sudo cp -r {} {}", self, backup_path.display())
                    } else {
                        write!(f, "sudo cp {} {}", self, backup_path.display())
                    }
                }
            }
            Self::Move(backup_path) => {
                if backup_path.starts_with(HOME) {
                    if backup_path.is_dir() {
                        write!(f, "mv -r {} {}", self, backup_path.display())
                    } else {
                        write!(f, "mv {} {}", self, backup_path.display())
                    }
                } else {
                    if backup_path.is_dir() {
                        write!(f, "sudo mv -r {} {}", self, backup_path.display())
                    } else {
                        write!(f, "sudo mv {} {}", self, backup_path.display())
                    }
                }
            }
        }
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct ConfigFile {
    source: PathBuf,
    backup: Backup,

    to_write: String,
}

impl ConfigFile {
    pub fn new(source: &Path) -> Self {
        Self {
            source: source.to_path_buf(),
            backup: Backup::None,

            to_write: String::new(),
        }
    }

    pub fn backup(mut self, backup: Backup) -> Self {
        self.backup = backup;

        self
    }

    pub fn to_write(mut self, to_write: String) -> Self {
        self.to_write = to_write;

        self
    }
}

impl Display for ConfigFile {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        if self.source.starts_with(HOME) {
            write!(
                f,
                "{} && echo \"{}\" | tee {} > /dev/null",
                self.to_write,
                self.source.display(),
                self.backup
            )
        } else {
            write!(
                f,
                "{} && echo \"{}\" | sudo tee {} > /dev/null",
                self.backup,
                self.to_write,
                self.source.display(),
            )
        }
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub enum Command {
    PreInstall { command: String, sudo: bool },
    PostInstall { command: String, sudo: bool },
}

impl Command {
    pub fn pre_install(command: &str) -> Self {
        Self::PreInstall {
            command: command.to_string(),

            sudo: false,
        }
    }

    pub fn post_install(command: &str) -> Self {
        Self::PostInstall {
            command: command.to_string(),

            sudo: false,
        }
    }

    pub fn sudo(mut self) -> Self {
        match self {
            Self::PreInstall { ref mut sudo, .. } => *sudo = true,
            Self::PostInstall { ref mut sudo, .. } => *sudo = true,
        }

        self
    }
}

impl Display for Command {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Self::PreInstall { command, sudo } => {
                if *sudo {
                    write!(f, "sudo {}", command)
                } else {
                    write!(f, "{}", command)
                }
            }
            Self::PostInstall { command, sudo } => {
                if *sudo {
                    write!(f, "sudo {}", command)
                } else {
                    write!(f, "{}", command)
                }
            }
        }
    }
}
