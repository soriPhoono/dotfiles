use std::{
    env::consts,
    fmt::{self, Display, Formatter},
    path::PathBuf,
    str::FromStr,
};

use super::{
    prelude::get_output, AUR_HELPER, CHECK_COMMAND, HOME, INSTALL_COMMAND, REMOVE_COMMAND,
    UNPACK_COMMAND,
};

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
pub struct Package {
    name: String,

    depends: Vec<Package>,
    conflicts: Vec<String>,

    from_archive: bool,
}

impl Package {
    pub fn system(name: &str) -> Self {
        Self {
            name: name.to_string(),

            conflicts: Vec::new(),
            depends: Vec::new(),

            from_archive: false,
        }
    }

    pub fn archive(name: &str) -> Self {
        Self {
            name: name.to_string(),

            conflicts: Vec::new(),
            depends: Vec::new(),

            from_archive: true,
        }
    }

    pub fn with_conflict(mut self, conflict: &str) -> Self {
        self.conflicts.push(conflict.to_string());

        self
    }

    pub fn with_conflicts(mut self, conflicts: Vec<String>) -> Self {
        self.conflicts.append(&mut conflicts.clone());

        self
    }

    pub fn with_depend(mut self, depend: Package) -> Self {
        self.depends.push(depend);

        self
    }

    pub fn with_depends(mut self, depends: Vec<Package>) -> Self {
        self.depends.append(&mut depends.clone());

        self
    }

    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn conflicts(&self) -> &Vec<String> {
        &self.conflicts
    }

    pub fn depends(&self) -> &Vec<Package> {
        &self.depends
    }

    pub fn from_archive(&self) -> bool {
        self.from_archive
    }
}

impl Display for Package {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        for depend in &self.depends {
            write!(f, "{}", depend)?;
        }

        if !self.conflicts.is_empty() {
            let current_installed =
                match get_output(format!("{} {}", AUR_HELPER, CHECK_COMMAND).as_str()) {
                    Ok(output) => output
                        .split('\n')
                        .map(|line| line.to_string())
                        .collect::<Vec<String>>(),
                    Err(why) => {
                        log::warn!("Failed to check installed packages: {}", why);

                        Vec::new()
                    }
                };

            for conflict in &self.conflicts {
                if current_installed
                    .iter()
                    .any(|installed| installed.contains(conflict))
                {
                    writeln!(f, "{} {} {}", AUR_HELPER, REMOVE_COMMAND, conflict)?;
                }
            }
        }

        if self.from_archive {
            writeln!(
                f,
                "{} {} https://archive.archlinux.org/packages/{}/{}/{}-{}.pkg.tar.zst",
                AUR_HELPER,
                UNPACK_COMMAND,
                match self.name.chars().nth(0) {
                    Some(letter) => letter,
                    None => {
                        log::warn!("Package has no name");

                        return Ok(());
                    }
                },
                self.name,
                self.name,
                consts::ARCH,
            )?;
        } else {
            writeln!(f, "{} {} {}", AUR_HELPER, INSTALL_COMMAND, self.name)?;
        }

        Ok(())
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
    Copy,
    Move,
    Restore,
}

impl Backup {
    pub fn none() -> Self {
        Self::None
    }

    pub fn copy() -> Self {
        Self::Copy
    }

    pub fn move_to() -> Self {
        Self::Move
    }

    pub fn restore() -> Self {
        Self::Restore
    }
}

impl Display for Backup {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Self::None => write!(f, ""),
            Self::Copy => {
                write!(f, "cp")
            }
            Self::Move => {
                write!(f, "mv")
            }
            Self::Restore => {
                write!(f, "mv")
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
    pub fn new(source: &str) -> Self {
        Self {
            source: PathBuf::from_str(source).unwrap(),
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
        let needs_sudo = self.source.starts_with(HOME);

        write!(
            f,
            "{}echo \n{}\n | {}tee {} > /dev/null",
            if let Backup::None = self.backup {
                String::new()
            } else {
                format!(
                    "{}{} {}{} && ",
                    if needs_sudo { "sudo " } else { "" },
                    self.backup,
                    if self.source.is_dir() { "-r " } else { "" },
                    if let Backup::Restore = self.backup {
                        format!(
                            "{} {}",
                            self.source.join(".bak").to_str().ok_or_else(|| {
                                log::warn!("Failed to convert path to string");

                                fmt::Error
                            })?,
                            self.source.to_str().ok_or_else(|| {
                                log::warn!("Failed to convert path to string");

                                fmt::Error
                            })?
                        )
                    } else {
                        format!(
                            "{} {}",
                            self.source.to_str().ok_or_else(|| {
                                log::warn!("Failed to convert path to string");

                                fmt::Error
                            })?,
                            self.source.join(".bak").to_str().ok_or_else(|| {
                                log::warn!("Failed to convert path to string");

                                fmt::Error
                            })?
                        )
                    }
                )
            },
            self.to_write,
            if needs_sudo { "sudo " } else { "" },
            self.source.display(),
        )
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
