use std::{
    fmt::{self, Display, Formatter},
    fs::File,
    io::{self, BufReader},
};

use crate::app::get_output;

use self::prelude::{ConfigFile, Package, Repository, Service};

pub mod system;

pub mod prelude {
    pub use super::system::prelude::*;
    pub use super::*;
}

pub const HOME: &str = env!("HOME");
pub const TARGETS_DIR: &str = "/.config/yadm/targets/";

pub const AUR_HELPER: &str = "paru";
pub const CHECK_COMMAND: &str = "-Q";
pub const UPDATE_COMMAND: &str = "-Syu --noconfirm";
pub const INSTALL_COMMAND: &str = "-S --needed --noconfirm";
pub const UNPACK_COMMAND: &str = "-U --noconfirm";
pub const REMOVE_COMMAND: &str = "-R --noconfirm";

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct BuildTarget {
    pub depends: Vec<String>,

    pub optional_repos: Vec<Repository>,

    pub config_files: Vec<ConfigFile>,
    pub packages: Vec<Package>,
    pub services: Vec<Service>,
}

#[derive(Debug, Clone)]
pub struct InstallTarget {
    optional_repos: Vec<Repository>,

    config_files: Vec<ConfigFile>,
    packages: Vec<Package>,
    services: Vec<Service>,
}

impl InstallTarget {
    pub fn new(build_target: BuildTarget) -> Result<Self, io::Error> {
        let mut optional_repos = Vec::new();
        let mut packages = Vec::new();
        let mut services = Vec::new();
        let mut config_files = Vec::new();

        for dependency in build_target.depends {
            let dependency: BuildTarget = serde_json::from_reader(BufReader::new(File::open(
                format!("{}{}{}.json", HOME, TARGETS_DIR, dependency),
            )?))?;

            let mut dependency = Self::new(dependency)?;

            optional_repos.append(&mut dependency.optional_repos);
            packages.append(&mut dependency.packages);
            services.append(&mut dependency.services);
            config_files.append(&mut dependency.config_files);
        }

        optional_repos.append(&mut build_target.optional_repos.clone());
        packages.append(&mut build_target.packages.clone());
        services.append(&mut build_target.services.clone());
        config_files.append(&mut build_target.config_files.clone());

        Ok(Self {
            optional_repos,
            config_files,
            packages,
            services,
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
}

impl Display for InstallTarget {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        for repository in self.optional_repos() {
            writeln!(f, "{}", repository)?;
        }

        writeln!(f, "paru {}", UPDATE_COMMAND)?; // TODO: migrate to controller
        writeln!(f)?;

        for package in self.packages() {
            writeln!(f, "{}", package)?;
        }

        for service in self.services() {
            writeln!(f, "{}", service)?;
        }

        for config_file in self.config_files() {
            writeln!(f, "{}", config_file)?;
        }

        Ok(())
    }
}
