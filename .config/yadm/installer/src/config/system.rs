use std::{
    env::consts,
    fmt::{self, Display, Formatter},
    path::{Path, PathBuf},
};

use super::HOME;

pub mod prelude {
    pub use super::*;
}

const AUR_HELPER: &str = "paru";
const UPDATE_COMMAND: &str = "-Syu --noconfirm";
const INSTALL_COMMAND: &str = "-S --needed --noconfirm";
const UNPACK_COMMAND: &str = "-U --noconfirm";
const REMOVE_COMMAND: &str = "-R --noconfirm";

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
    System { name: String, aur: bool },
    Archive(String),
}

impl Package {
    pub fn system(name: &str) -> Self {
        Self::System {
            name: name.to_string(),

            aur: false,
        }
    }

    pub fn aur(name: &str) -> Self {
        Self::System {
            name: name.to_string(),

            aur: true,
        }
    }

    pub fn archive(name: &str) -> Self {
        Self::Archive(name.to_string())
    }
}

pub struct PackageGroup {
    aur_helper: bool,

    install: Vec<Package>,
}

impl PackageGroup {
    pub fn new() -> Self {
        Self {
            aur_helper: false,

            install: Vec::new(),
        }
    }

    pub fn aur_helper(mut self, aur_helper: bool) -> Self {
        self.aur_helper = aur_helper;

        self
    }

    pub fn install(mut self, package: Package) -> Self {
        self.install.push(package);

        self
    }

    pub fn install_many(mut self, packages: Vec<Package>) -> Self {
        self.install.extend(packages);

        self
    }
}

impl Display for PackageGroup {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        if self.aur_helper {
            writeln!(f, "paru {}", UPDATE_COMMAND)?; // TODO: migrate to controller
        } else {
            writeln!(f, "sudo pacman {}", UPDATE_COMMAND)?; // TODO: migrate to controller
            writeln!(f, "sudo mkdir --parents /tmp/dfm/")?; // TODO: migrate to controller
        }

        for package in &self.install {
            match package {
                Package::System { name, aur } => {
                    if aur && self.aur_helper {
                        writeln!(f, "{} {} {}", AUR_HELPER, INSTALL_COMMAND, name)?;
                    } else if aur {
                        writeln!(
                            f,
                            "git clone https://aur.archlinux.org/{}.git /tmp/dfm/{}",
                            name, name
                        )?;
                        writeln!(f, "cd /tmp/dfm/{}", name)?;
                        writeln!(f, "makepkg -si --noconfirm")?;
                    } else if self.aur_helper {
                        writeln!(f, "{} {} {}", AUR_HELPER, INSTALL_COMMAND, name)?;
                    } else {
                        writeln!(f, "sudo pacman {} {}", INSTALL_COMMAND, name)?;
                    }
                }
                Package::Archive(name) => {
                    writeln!(
                        f,
                        "sudo pacman {} https://archive.archlinux.org/packages/{}/{}/{}-{}.pkg.tar.zst",
                        UNPACK_COMMAND,
                        match name.chars().nth(0) {
                            Some(letter) => letter,
                            None => {
                                log::warn!("Package has no name");

                                return Ok(());
                            }
                        },
                        name,
                        name,
                        consts::ARCH,
                    )?;
                }
            }
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
