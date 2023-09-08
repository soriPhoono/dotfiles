use std::{
    env::consts,
    fmt::{self, Display, Formatter},
    path::PathBuf,
    str::FromStr,
};

use super::{
    prelude::get_output, AUR_HELPER, CHECK_COMMAND, HOME, INSTALL_COMMAND, REMOVE_COMMAND,
    UNPACK_COMMAND, UPDATE_COMMAND,
};

pub mod prelude {
    pub use super::*;
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Repository {
    name: String,

    bootstrap_commands: Vec<String>,
    pacman_entry: String,
}

impl Repository {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),

            bootstrap_commands: vec![format!("{} {}", AUR_HELPER, UPDATE_COMMAND)],
            pacman_entry: String::new(),
        }
    }

    pub fn bootstrap_command(mut self, command: &str) -> Self {
        self.bootstrap_commands.push(command.to_string());

        self
    }

    pub fn pacman_entry(mut self, entry: &str) -> Self {
        self.pacman_entry = entry.to_string();

        self
    }
}

impl Display for Repository {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        if !self.bootstrap_commands.is_empty() {
            for command in &self.bootstrap_commands {
                writeln!(f, "{} > /dev/null", command)?;
            }
        } else {
            log::warn!("Repository {} has no bootstrap commands", self.name);
        }

        if !self.pacman_entry.is_empty() {
            writeln!(
                f,
                "echo -e '{}' | sudo tee -a /etc/pacman.conf",
                self.pacman_entry
            )?;
        } else {
            log::warn!("Repository {} has no pacman entry", self.name);
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

    post_install: Vec<String>,
    config_files: Vec<ConfigFile>,
}

impl Package {
    pub fn system(name: &str) -> Self {
        Self {
            name: name.to_string(),

            conflicts: Vec::new(),
            depends: Vec::new(),

            from_archive: false,

            post_install: vec![],
            config_files: vec![],
        }
    }

    pub fn archive(name: &str) -> Self {
        Self {
            name: name.to_string(),

            conflicts: Vec::new(),
            depends: Vec::new(),

            from_archive: true,

            post_install: vec![],
            config_files: vec![],
        }
    }

    pub fn with_depend(mut self, depend: Package) -> Self {
        self.depends.push(depend);

        self
    }

    pub fn with_conflict(mut self, conflict: &str) -> Self {
        self.conflicts.push(conflict.to_string());

        self
    }

    pub fn post_install(mut self, command: String) -> Self {
        self.post_install.push(command);

        self
    }

    pub fn config_file(mut self, config_file: ConfigFile) -> Self {
        self.config_files.push(config_file);

        self
    }

    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn depends(&self) -> &Vec<Package> {
        &self.depends
    }

    pub fn conflicts(&self) -> &Vec<String> {
        &self.conflicts
    }

    pub fn from_archive(&self) -> bool {
        self.from_archive
    }

    pub fn post_install_commands(&self) -> &Vec<String> {
        &self.post_install
    }

    pub fn config_files(&self) -> &Vec<ConfigFile> {
        &self.config_files
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
                        panic!("Failed to check installed packages: {}", why);
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

        for command in &self.post_install {
            writeln!(f, "{} > /dev/null", command)?;
        }

        for config_file in &self.config_files {
            writeln!(f, "{}", config_file)?;
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
        write!(
            f,
            "{}systemctl {}{} {}",
            if self.user { "" } else { "sudo " },
            if self.user { "--user " } else { "" },
            if self.enable && self.start {
                "enable --now"
            } else if self.enable {
                "enable"
            } else if self.start {
                "start"
            } else {
                log::warn!("Service {} has no action", self.name);

                return Ok(());
            },
            self.name
        )
    }
}

#[derive(Debug, Clone, PartialEq, Eq, serde::Serialize, serde::Deserialize)]
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

    commands: Vec<String>,
}

impl ConfigFile {
    pub fn new(source: &str) -> Self {
        Self {
            source: PathBuf::from_str(source).unwrap(),
            backup: Backup::None,

            commands: Vec::new(),
        }
    }

    pub fn backup(mut self, backup: Backup) -> Self {
        self.backup = backup;

        self
    }

    pub fn command(mut self, to_run: &str) -> Self {
        self.commands.push(to_run.to_string());

        self
    }
}

impl Display for ConfigFile {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        let needs_sudo = self.source.starts_with(HOME);

        // backup file if needed
        if self.backup != Backup::None {
            let backup_target = self.source.join(".bak");

            let op_source = match self.backup {
                Backup::Restore => &backup_target,
                _ => self.source.as_path(),
            };

            let op_dest = match self.backup {
                Backup::Restore => self.source.as_path(),
                _ => &backup_target,
            };

            write!(
                f,
                "{}{} {}{} {}",
                if needs_sudo { "sudo " } else { "" },
                self.backup,
                if self.source.is_dir() { "-r " } else { "" },
                op_source.to_str().ok_or_else(|| {
                    log::warn!("Failed to convert path to string");

                    fmt::Error
                })?,
                op_dest.to_str().ok_or_else(|| {
                    log::warn!("Failed to convert path to string");

                    fmt::Error
                })?,
            )?;
        }

        for command in &self.commands {
            write!(f, "{} > /dev/null", command)?;
        }

        Ok(())
    }
}
