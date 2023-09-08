use std::{
    error,
    fmt::{Debug, Display},
    io::{stdin, stdout, Write},
    path::PathBuf,
    process::{Child, Command},
    str::FromStr,
};

#[derive(Debug, clap::Parser)]
#[command(author, version, about, long_about = None)]
pub struct Cli {
    #[command(subcommand)]
    pub subcommand: Commands,
}

#[derive(Debug, clap::Subcommand)]
pub enum Commands {
    Install {
        #[arg(short, long)]
        target: Option<PathBuf>,
    },

    Create {
        #[arg(short, long)]
        target: PathBuf,
    },
}

pub fn create_subprocess(command: &str) -> Result<Child, Box<dyn error::Error>> {
    if command.is_empty() {
        return Err("Command is empty".into());
    }

    let mut command_parts = command.split_whitespace();

    let command = command_parts.next().unwrap();

    Command::new(command)
        .args(command_parts)
        .spawn()
        .map_err(|e| format!("Failed to spawn command: {}", e).into())
}

pub fn get_output(command: &str) -> Result<String, Box<dyn error::Error>> {
    Ok(create_subprocess(command)?
        .wait_with_output()?
        .stdout
        .iter()
        .map(|byte| *byte as char)
        .collect::<String>())
}

pub fn check_output(command: &str) -> Result<bool, Box<dyn error::Error>> {
    Ok(create_subprocess(command)?.wait()?.success())
}
