# PC Dotfiles

This repository contains my personal dotfiles for my PC. It includes configuration files for various programs and scripts to automate the installation of these files.

This is targeted at a NixOS system!

## Installation

To install these dotfiles, simply run the following command:

```bash
cd installer && nix-shell --command "python installer/src/main.py"
```

This will execute the installer script in a nix-shell with all required dependencies for the script. This installer script will take you from the minimal installer or graphical client to a fully riced and stably configured system.
