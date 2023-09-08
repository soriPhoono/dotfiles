use std::{
    error,
    fmt::{self, Display, Formatter},
    path::PathBuf,
    str::FromStr,
};

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Version {
    major: u8,
    minor: u8,
    patch: Option<u8>,
}

impl Version {
    pub fn new(major: u8, minor: u8) -> Self {
        Self {
            major,
            minor,
            patch: None,
        }
    }

    pub fn with_patch(mut self, patch: u8) -> Self {
        self.patch = Some(patch);

        self
    }

    pub fn major(&self) -> u8 {
        self.major
    }

    pub fn minor(&self) -> u8 {
        self.minor
    }

    pub fn patch(&self) -> Option<u8> {
        self.patch.as_ref().map(|patch| *patch)
    }
}

impl Default for Version {
    fn default() -> Self {
        Self::new(0, 1)
    }
}

impl Display for Version {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{}.{}", self.major, self.minor)?;

        if let Some(patch) = &self.patch {
            write!(f, ".{}", patch)
        } else {
            Ok(())
        }
    }
}

impl FromStr for Version {
    type Err = Box<dyn error::Error>;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let mut version_parts = s.split(".");

        let major = version_parts
            .next()
            .map(|major_str| major_str.parse())
            .transpose()?
            .ok_or_else(|| "Failed to find major version component")?;
        let minor = version_parts
            .next()
            .map(|minor_str| minor_str.parse())
            .transpose()?
            .ok_or_else(|| "Failed to find minor version component")?;
        let patch = version_parts
            .next()
            .map(|patch_str| patch_str.parse())
            .transpose()?;

        Ok(Self {
            major,
            minor,
            patch,
        })
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Repository {
    name: String,

    bootstrap_commands: Vec<String>,
}

pub trait Package {
    fn get_install_command(&self) -> String;
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct SystemPackage {
    name: String,
    version: Option<Version>,
}

impl SystemPackage {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            version: None,
        }
    }

    pub fn with_version(mut self, version: Version) -> Self {
        self.version = Some(version);

        self
    }
}

impl Package for SystemPackage {
    fn get_install_command(&self) -> String {
        let mut command = String::new();

        command.push_str("sudo pacman -S --needed --noconfirm ");

        command
    }
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct AurPackage {
    name: String,

    build_directory: PathBuf,
}

impl AurPackage {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),

            build_directory: PathBuf::from("/tmp"),
        }
    }
}

impl Package for AurPackage {
    fn get_install_command(&self) -> String {
        let mut command = String::new();

        command.push_str(
            format!(
                "git clone https://aur.archlinux.org/{}.git /tmp/{}",
                self.name, self.name
            )
            .as_str(),
        );
        command.push_str(format!("&& cd /tmp/{}", self.name).as_str());
        command.push_str("&& makepkg -si");

        command
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
pub enum ConfigFile {
    CopyToBackup(PathBuf),
    MoveToBackup(PathBuf),
}

impl Display for ConfigFile {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Self::CopyToBackup(path) => {
                write!(f, "sudo cp {} {}.bak", path.display(), path.display())
            }
            Self::MoveToBackup(path) => {
                write!(f, "sudo mv {} {}.bak", path.display(), path.display())
            }
        }
    }
}
