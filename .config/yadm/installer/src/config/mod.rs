use std::path::PathBuf;

pub mod system;

pub mod prelude {
    pub use super::system::prelude::*;
    pub use super::{InstallerConfig, Target, Version};
}

const HOME: &str = env!("HOME");

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct Target {
    depends: Vec<String>,

    packages: Vec<Package>,
    services: Vec<Service>,
    config_files: Vec<ConfigFile>,

    commands: Vec<String>,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct InstallerConfig {
    optional_repos: Vec<Repository>,

    install_targets: Vec<Target>,
}
