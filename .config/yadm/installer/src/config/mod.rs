use std::{
    env::consts,
    fmt::{self, Display, Formatter},
    fs::File,
    io::{self, BufReader},
};

use self::prelude::{Command, ConfigFile, Package, Repository, Service};

pub mod system;

pub mod prelude {
    pub use super::system::prelude::*;
    pub use super::*;
}

const HOME: &str = env!("HOME");
const TARGETS_DIR: &str = "/.config/yadm/targets/";

const AUR_HELPER: &str = "paru";
const UPDATE_COMMAND: &str = "-Syu --noconfirm";
const INSTALL_COMMAND: &str = "-S --needed --noconfirm";
const UNPACK_COMMAND: &str = "-U --noconfirm";
const REMOVE_COMMAND: &str = "-R --noconfirm";

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct BuildTarget {
    pub depends: Vec<String>,

    pub optional_repos: Vec<Repository>,

    pub packages: Vec<Package>,
    pub services: Vec<Service>,
    pub config_files: Vec<ConfigFile>,

    pub commands: Vec<Command>,
}

#[derive(Debug, Clone)]
pub struct InstallTarget {
    optional_repos: Vec<Repository>,

    packages: Vec<Package>,
    services: Vec<Service>,
    config_files: Vec<ConfigFile>,

    commands: Vec<Command>,
}

impl InstallTarget {
    pub fn new(build_target: BuildTarget) -> Result<Self, io::Error> {
        let mut optional_repos = Vec::new();
        let mut packages = Vec::new();
        let mut services = Vec::new();
        let mut config_files = Vec::new();
        let mut commands = Vec::new();

        for dependency in build_target.depends {
            let dependency: BuildTarget = serde_json::from_reader(BufReader::new(File::open(
                format!("{}{}{}.json", HOME, TARGETS_DIR, dependency),
            )?))?;

            let mut dependency = Self::new(dependency)?;

            optional_repos.append(&mut dependency.optional_repos);
            packages.append(&mut dependency.packages);
            services.append(&mut dependency.services);
            config_files.append(&mut dependency.config_files);
            commands.append(&mut dependency.commands);
        }

        optional_repos.append(&mut build_target.optional_repos.clone());
        packages.append(&mut build_target.packages.clone());
        services.append(&mut build_target.services.clone());
        config_files.append(&mut build_target.config_files.clone());
        commands.append(&mut build_target.commands.clone());

        Ok(Self {
            optional_repos,
            packages,
            services,
            config_files,
            commands,
        })
    }

    pub fn optional_repos(&self) -> &Vec<Repository> {
        &self.optional_repos
    }

    pub fn packages(&self) -> &Vec<Package> {
        &self.packages
    }

    pub fn services(&self) -> &Vec<Service> {
        &self.services
    }

    pub fn config_files(&self) -> &Vec<ConfigFile> {
        &self.config_files
    }

    pub fn commands(&self) -> &Vec<Command> {
        &self.commands
    }
}

impl Display for InstallTarget {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        for pre_install in self.commands().iter().filter(|command| match command {
            Command::PreInstall { .. } => true,
            _ => false,
        }) {
            writeln!(f, "{}", pre_install)?;
        }

        for repository in self.optional_repos() {
            writeln!(f, "{}", repository)?;
        }

        writeln!(f, "paru {}", UPDATE_COMMAND)?; // TODO: migrate to controller

        for package in self.packages() {
            
        }

        for service in self.services() {
            writeln!(f, "{}", service)?;
        }

        for config_file in self.config_files() {
            writeln!(f, "{}", config_file)?;
        }

        for post_install in self.commands().iter().filter(|command| match command {
            Command::PostInstall { .. } => true,
            _ => false,
        }) {
            writeln!(f, "{}", post_install)?;
        }

        Ok(())
    }
}
